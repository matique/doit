require 'simplecov'
SimpleCov.start do
  add_filter 'test'
  command_name 'Minitest'
end

require 'what'

require 'minitest/autorun'

def noop(options = {noop: true}, &block)
  return 'noop: missing block' unless block

  out = '---'
  Doit.stub :options, options do
    out, _err = capture_io do
      block.call
    end
  end
  out
end
