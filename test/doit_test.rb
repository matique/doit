require 'test_helper'
require 'doit'

describe Doit do

  before do
    Doit.start({})
  end

  it "start" do
    out = noop { }
    assert_equal '', out
  end

  it "options" do
    assert_equal({}, Doit.options)
  end

  it "list" do
    out = noop {
      Doit.list
    }
    assert_match /\/\.doit/, out
  end

  it "execute" do
    out, err = capture_io do
      Doit.execute('hello')
    end
    assert_match /\nHello\n/, out
  end

  it "execute with unknown script" do
    out, err = capture_io do
      Doit.execute('______unknown______')
    end
    assert_match /not found/, out
  end

end
