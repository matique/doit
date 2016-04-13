require 'test_helper'
require 'my'

describe My do

  it "verbose" do
    h = 'hello'
    _out, _err = capture_io do
      My.verbose('a', h)
    end
    assert_match(/#{h}/, _out)
  end

  it "verbose text" do
    h = 'hello'
    _out, _err = capture_io do
      My.verbose('a', "#{h}\nx\n")
    end
    assert_match(/#{h}/, _out)
  end

end
