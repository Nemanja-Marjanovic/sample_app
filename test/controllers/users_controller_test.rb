require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:nemanja)
    @other_user = users(:nenad)
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
    assert_select "title", full_title("Sign up")
  end
  
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect index if not logged in" do
    get users_path
    assert_redirected_to login_url
  end
  
  test "should show index if logged in" do
    log_in_as(@user)
    get users_path
    assert_response :success
  end
  
end
