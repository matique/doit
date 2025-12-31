if ENV["COVERAGE"]
  require "simplecov"
  SimpleCov.start do
    add_filter "/test/"
  end
end

require "what"

require "minitest/autorun"

def noop(options = {noop: true}, &block)
  return "noop: missing block" unless block

  out = "---"
  save_options = Doit.options
  Doit.options = options
  out, _err = capture_io do
    yield
  end
  Doit.options = save_options

  out
end
