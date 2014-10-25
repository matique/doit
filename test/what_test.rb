require 'test_helper'
require 'what'
require 'my'

describe What do

  it "is robust against empty params" do
    What.init('', '')
    assert_equal [Dir.pwd], What.where
    assert_equal [{}], What.matrix
  end

  it "#to_env({}) must be ''" do
    assert_equal '', What.to_env({})
  end

  it "to_env converts variable to uppercase" do
    assert_equal 'A=1', What.to_env({a: 1})
  end

  it "coverage: #info" do
    Doit.stub :options, {verbose: true} do
      out, err = capture_io do
	What.init('', '')
	What.info
      end
    end
  end

  it "builds simple matrix" do
    What.init('', "a: 1\n")
    assert_equal [{"a"=>1}], What.matrix
  end

  it "builds matrix" do
    What.init('', "a:\n - 1\n - 2\n")
    assert_equal [{"a"=>1}, {"a"=>2}], What.matrix
  end

  it "builds product matrix" do
    What.init('', "a:\n - 1\nb:\n - 3\n - 4\n")
    assert_equal [{"a"=>1, "b"=>3}, {"a"=>1, "b"=>4}], What.matrix
  end

end
