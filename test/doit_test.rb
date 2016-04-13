require 'test_helper'

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
    assert_match(/\/\.doit/, out)
  end

  it "execute" do
    out, _err = capture_io do
      Doit.execute('hello')
    end
    assert_match(/\nHello\n/, out)
  end

  it "execute with unknown script" do
    out, _err = capture_io do
      Doit.execute('______unknown______')
    end
    assert_match(/not found/, out)
  end

  it "tests option --each" do
    out = noop({each: true}) {
      Doit.execute('hello')
    }
    assert_match(/doit hello -r/, out)
  end

  it "coverage: list; option -lv" do
    out = noop({verbose: true, list: true}) {
      Doit.start({verbose: true, list: true})
    }
    assert_match(/just a test\n/, out)
  end

end
