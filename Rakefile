# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]

task :rust_build do
    `cargo rustc --release`
    `mv -f ./target/release/libfib.so ./lib/fib`
end

task :build => :rust_build
task :spec => :rust_build

task :rust_clean do
  `cargo clean`
  `rm -f ./lib/fib/libfib.so`
end

task :clean => :rust_clean
