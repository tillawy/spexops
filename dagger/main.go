// A generated module for SpexopsBackend functions
//
// This module has been generated via dagger init and serves as a reference to
// basic module structure as you get started with Dagger.
//
// Two functions have been pre-created. You can modify, delete, or add to them,
// as needed. They demonstrate usage of arguments and return types using simple
// echo and grep commands. The functions can be called from the dagger CLI or
// from one of the SDKs.
//
// The first line in this comment block is a short description line and the
// rest is a long description with more detail on the module's purpose or usage,
// if appropriate. All modules should have a short description.

package main

import (
	"context"
	"dagger/spexops-backend/internal/dagger"
	"fmt"
	"math"
	"math/rand"
)

type SpexopsBackend struct{}

// Returns a container that echoes whatever string argument is provided
func (m *SpexopsBackend) ContainerEcho(stringArg string) *dagger.Container {
	return dag.Container().From("alpine:latest").WithExec([]string{"echo", stringArg})
}

//dagger call publish --source=.
// Publish the application container after building and testing it on-the-fly
func (m *SpexopsBackend) Publish(ctx context.Context, source *dagger.Directory) (string, error) {
	_, err := m.Test(ctx, source)
	if err != nil {
		return "", err
	}
	return m.Build(ctx, source).
		Publish(ctx, fmt.Sprintf("ttl.sh/spexops-arm-dagger-%.0f", math.Floor(rand.Float64()*10000000)))
}

// Build the application container
func (m *SpexopsBackend) Build(ctx context.Context, source *dagger.Directory) *dagger.Container {
	return dag.Container().
		WithDirectory("/rails", source).
		WithWorkdir("/rails").
		Directory("/rails").
		DockerBuild()
	//return m.BuildEnv(source)
}

// Returns lines that match a pattern in the files of the provided Directory
func (m *SpexopsBackend) GrepDir(ctx context.Context, directoryArg *dagger.Directory, pattern string) (string, error) {
	return dag.Container().
		From("alpine:latest").
		WithMountedDirectory("/mnt", directoryArg).
		WithWorkdir("/mnt").
		WithExec([]string{"grep", "-R", pattern, "."}).
		Stdout(ctx)
}

// Return the result of running unit tests
// dagger call test --source=.
func (m *SpexopsBackend) Test(ctx context.Context, source *dagger.Directory) (string, error) {
	return m.TestEnv(ctx, source).
		WithExec([]string{"bundle", "exec", "rake", "db:setup"}).
		WithExec([]string{"bundle", "exec", "rspec"}).
		WithExec([]string{"bundle", "exec", "rubocop"}).
		WithExec([]string{"bundle", "exec", "bundle-audit"}).
		WithExec([]string{"bundle", "exec", "brakeman"}).
		Stdout(ctx)
}

func (m *SpexopsBackend) ChromeService(ctx context.Context) *dagger.Service {
	return dag.Container().
		From("selenium/standalone-chromium").
		WithExposedPort(4444).
		WithExposedPort(7900).
		AsService()
}

func (m *SpexopsBackend) Postgres(ctx context.Context) *dagger.Container {
	return dag.Container().
		From("ankane/pgvector").
		WithEnvVariable("POSTGRES_USER", "postgres").
		WithEnvVariable("POSTGRES_PASSWORD", "password").
		WithExposedPort(5432)
}

func (m *SpexopsBackend) PostgresService(ctx context.Context) *dagger.Service {
	return m.Postgres(ctx).AsService()
}

//  dagger call test-env --source=. terminal --cmd=bash
func (m *SpexopsBackend) TestEnv(ctx context.Context, source *dagger.Directory) (*dagger.Container) {
	return m.BuildEnv(source).
		WithServiceBinding("db", m.PostgresService(ctx)).
		WithServiceBinding("chrome", m.ChromeService(ctx)).
		WithEnvVariable("SELENIUM_HOST", "chrome").
		WithEnvVariable("DB_HOST", "db").
		WithEnvVariable("DATABASE_CABLE_RW_URL", "postgresql://db:5432/").
		WithEnvVariable("DATABASE_CACHE_RW_URL", "postgresql://db:5432/").
		WithEnvVariable("DATABASE_CACHE_RO_URL", "postgresql://db:5432/").
		WithEnvVariable("DATABASE_QUEUE_RW_URL", "postgresql://db:5432/").
		WithEnvVariable("DATABASE_QUEUE_RO_URL", "postgresql://db:5432/").
		WithEnvVariable("DATABASE_PRIMARY_RW_URL", "postgresql://db:5432/").
		WithEnvVariable("DATABASE_PRIMARY_RO_URL", "postgresql://db:5432/").
		WithEnvVariable("DATABASE_ACCOUNTS_RW_URL", "postgresql://db:5432/").
		WithEnvVariable("DATABASE_ACCOUNTS_RO_URL", "postgresql://db:5432/").
		WithEnvVariable("DATABASE_PROJECTS_RW_URL", "postgresql://db:5432/").
		WithEnvVariable("DATABASE_PROJECTS_RO_URL", "postgresql://db:5432/").
		WithEnvVariable("DATABASE_FEATURES_RW_URL", "postgresql://db:5432/").
		WithEnvVariable("DATABASE_FEATURES_RO_URL", "postgresql://db:5432/").
		WithEnvVariable("DATABASE_SUITES_RW_URL", "postgresql://db:5432/").
		WithEnvVariable("DATABASE_SUITES_RO_URL", "postgresql://db:5432/").
		WithEnvVariable("DATABASE_SPECS_RW_URL", "postgresql://db:5432/").
		WithEnvVariable("DATABASE_SPECS_RO_URL", "postgresql://db:5432/").
		WithEnvVariable("DATABASE_VERSIONS_RW_URL", "postgresql://db:5432/").
		WithEnvVariable("DATABASE_VERSIONS_RO_URL", "postgresql://db:5432/").
		WithEnvVariable("ACTIVE_RECORD_ENCRYPTION_DETERMINISTIC_KEY", "deterministickeyaaaaaaaaaaaaaaaa").
		WithEnvVariable("ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT", "keyderivationsaltbbbbbbbbbbbbbbb").
		WithEnvVariable("ACTIVE_RECORD_ENCRYPTION_PRIMARY_KEY", "primarykeycccccccddddddddddddddd").
		WithEnvVariable("COVERAGE", "0").
		WithEnvVariable("RAILS_ENV", "test").
		WithEnvVariable("DATABASE_PASSWORD", "password"). // password set in db container
		WithEnvVariable("DATABASE_USERNAME", "postgres"). // default user in postgres image
		WithEnvVariable("DATABASE_SUPER_PASSWORD", "password"). // password set in db container
		WithEnvVariable("DATABASE_SUPER_USERNAME", "postgres"). // default user in postgres image
		WithEnvVariable("DB_NAME", "postgres")     // default db name in postgres image
}

// dagger call build-env --source=. terminal --cmd=bash
func (m *SpexopsBackend) BuildEnv(source *dagger.Directory) *dagger.Container {
	rubyCache := dag.CacheVolume("rails-spexops")
	aptCache := dag.CacheVolume("apt-spexops")
	return dag.Container().
	    From("registry.docker.com/library/ruby:3.3.5").
		WithMountedCache("/var/cache/apt/archives/", aptCache).
		WithExec([]string{"apt", "update"}).
		WithExec([]string{"apt", "install", "--no-install-recommends" , "-y" , "build-essential" , "git" , "libpq-dev" ,"libvips" , "pkg-config", "curl", "libvips", "postgresql-client"}).
		WithMountedCache("/usr/local/bundle", rubyCache).
		WithDirectory("/rails", source).
		WithWorkdir("/rails").
		WithExec([]string{"bundle", "install"})
}
