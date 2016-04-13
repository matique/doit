require 'test_helper'
require 'import'
require 'doit'
require 'my'

describe Import do

  it "init fails with empty" do
    assert_raises(Errno::EISDIR) { Import.init('') }
  end

  it "init" do
    Import.init('hello')
  end

  it "list" do
    Import.init('hello')
    assert_match(/\/\.doit\/hello$/, Import.list['hello'])
  end

  it "info" do
    out = noop({verbose: true}) {
	Import.init('hello')
	Import.info
    }
    assert_match(/SCRIPT/, out)
    assert_match(/CONFIG/, out)
  end

  it "coverage: script" do
    Import.script
  end

  it "coverage: config" do
    Import.config
  end

end
