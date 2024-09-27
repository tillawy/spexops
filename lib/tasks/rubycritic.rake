require "rubycritic/rake_task"

RubyCritic::RakeTask.new do |task|
  # Name of RubyCritic task. Defaults to :rubycritic.
  task.name = "rubycritic"

  # Glob pattern to match source files. Defaults to FileList['.'].
  task.paths = FileList["app/**/*.rb"]

  # You can pass all the options here in that are shown by "rubycritic -h" except for
  # "-p / --path" since that is set separately. Defaults to ''.
  # task.options = "--mode-ci --format html --minimum-score 99 --path=public/rubycritic/ --no-browser"
  task.options = "--format html --minimum-score 99 --path=public/rubycritic/ --no-browser"

  # Defaults to false
  task.verbose = true
end
