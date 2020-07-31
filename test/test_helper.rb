require "simplecov"
SimpleCov.root ".."
SimpleCov.add_filter "/test/"
SimpleCov.start

require "codecov"
SimpleCov.formatter = SimpleCov::Formatter::Codecov

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "minitest/autorun"