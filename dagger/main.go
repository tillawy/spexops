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
	"dagger/ckretz/internal/dagger"
	"fmt"
	"math"
	"math/rand"
)

type SpexopsBackend struct{}

// Returns a container that echoes whatever string argument is provided
func (m *SpexopsBackend) ContainerEcho(stringArg string) *dagger.Container {
	return dag.Container().From("alpine:latest").WithExec([]string{"echo", stringArg})
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

func (m *SpexopsBackend) BuildEnv(source *dagger.Directory) *dagger.Container {
	rubyCache := dag.CacheVolume("rails-spexops")
	aptCache := dag.CacheVolume("apt-spexops")
	return dag.Container().
	    From("ghcr.io/rails/devcontainer/images/ruby:3.3.5").
		WithMountedCache("/var/cache/apt/archives/", aptCache).
// 		WithExec([]string{"apt", "update"}).
// 		WithExec([]string{"apt", "install", "--no-install-recommends" , "-y" , "build-essential" , "git" , "libpq-dev" ,"libvips" , "pkg-config", "curl", "libvips", "postgresql-client"}).
// 		WithMountedCache("/usr/local/bundle", rubyCache).
// 		WithDirectory("/rails", source).
// 		WithWorkdir("/rails").
		WithExec([]string{"bundle", "install"})
}
