require 'test_helper'

class VersionTest < ActiveSupport::TestCase
  test "should have a version number" do
    refute_nil ::ExceptionNotifierSlack::VERSION
  end
end
