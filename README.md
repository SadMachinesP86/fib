# Fib

The purpose of this project is to experiment with the creation of Ruby extensions built in Rust. This project provides a Ruby gem which implements the Fibonacci algorithm, both in Rust and in native Ruby.

The code is basically copy-pasted from [this article](https://dev.to/kojix2/making-rubygem-with-rust-2ji6) - I added the native Ruby implementation and the `with_metrics` functionality to allow for the comparison of performance between Rust and Ruby.

# Usage

Note that, while structured as a gem, this project is intended to be cloned, built, and executed from the command line.

After cloning, bundle install and then build the Rust library (provided as a Rake task):

```bash
bundle install
rake build
```

Then enter an IRB session with `bin/console`. The project defines a `Fib` module with `rust` and `ruby` methods, implementing the algorithm in the respective language:

```ruby
Fib.ruby(5) # Evaluates the fifth item in the Fibonacci sequence in plain Ruby.
Fib.rust(5) # The same value, calling the Rust implementation.
```

# Notes

Here's the basic process I used to make the project:

## Initialization of Ruby gem and Rust library

```bash
# Initialize the Ruby gem
bundle gem fib -t rspec
cd fib
# Initialize the Rust library
cargo init --lib
```

This generates a skeleton of a Ruby gem, with an empty Rust library inside it.

Add the following to Cargo.toml to instruct Cargo to compile the Rust code as a dynamic library:

```toml
[lib]
crate-type = ["cdylib"]
```

Add the following to the Rakefile to define a Rake task to compile the library:

```ruby
task :rust_build do
    `cargo rustc --release`
    `mv -f ./target/release/libfib.so ./lib/fib`
end

task :build => :rust_build
task :spec => :rust_build
```

## Code Implementation

Now that the basic skeleton is set up:

* Add Rust code under `src/`, defining the public-facing API in `src/lib.rs`
* Add Ruby code under `lib/`, defining the public-facing API in `lib/fib.rb`, and the foreign function interface into the Rust library in `lib/fib/ffi.rb`
* Build with `rake build`
* Run with `bin/console`
