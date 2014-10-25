require 'test_helper'
require 'run'
require 'my'
require 'doit'

describe Run do

  it "coverage #info" do
    out, err = capture_io do
      Run.init('', '')
      Run.info
    end
  end

  it "where '' returns nil" do
    out, err = capture_io do
      Run.init('', '')
      assert_equal nil, Run.ssh
    end
  end

  it "where 'a' returns nil" do
    out, err = capture_io do
      Run.init('', 'a')
      assert_equal nil, Run.ssh
    end
  end

  it "where 'a@b' returns 'ssh a@b'" do
    out, err = capture_io do
      Run.init('', 'a@b')
      assert_equal 'ssh a@b', Run.ssh
    end
  end

  it "where 'a@b:c' returns 'ssh a@b'" do
    out, err = capture_io do
      Run.init('', 'a@b:c')
      assert_equal 'ssh a@b', Run.ssh
    end
  end

  it "coverage #run" do
    out, err = capture_io do
      Run.init('', '')
      Run.run
    end
  end

  it "coverage #run noop" do
    out = noop {
	Run.init('', '')
	Run.run
    }
    assert_match /EOS/, out
  end

end
