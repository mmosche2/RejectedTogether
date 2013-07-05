require 'test_helper'
require "httparty"

class UsersControllerTest < ActionController::TestCase
  
  test "ame user deletes their question" do
    get :index
    assert_response :success
  end

end