require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "user is authenticatable" do
    assert users(:admin).authenticate(default_password)
    refute users(:admin).authenticate('incorrect')
  end
end
