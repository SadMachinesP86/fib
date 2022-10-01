# frozen_string_literal: true

require_relative "fib/version"
require_relative "fib/ffi"

module Fib
  class Error < StandardError; end

  def self.rust(n)
    with_metrics do
      FFI.fib(n)
    end
  end

  def self.ruby(n)
    with_metrics do
      self.fib(n)
    end
  end

  private

  def self.with_metrics(&block)
    start = Time.now
    value = yield
    puts "Time to calculate: #{(Time.now - start) * 1000}ms"
    value
  end

  def self.fib(n)
    if n <= 1
      n
    else
      self.fib(n - 1) + self.fib(n - 2)
    end
  end
end
