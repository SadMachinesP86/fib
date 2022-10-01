require 'fiddle/import'

module Fib
  module FFI
    extend Fiddle::Importer
    dlload File.expand_path('libfib.so', __dir__)
    extern 'unsigned int fib(unsigned int n)'
  end
end
