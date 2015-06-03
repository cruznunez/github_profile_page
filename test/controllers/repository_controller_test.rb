require 'test_helper'

class RepositoryControllerTest < ActionController::TestCase
  test "should get post" do
    get :form
    assert_response :success
  end

  test "should get index" do
    post :index
    assert_response :success
  end

end
