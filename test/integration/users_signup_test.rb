require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "Invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: {name: "", email: "nije@dobro", password: "nemanja", password_confirmation: "marjanovic" }}
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end
  
  test "valid user signup" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {name: "Nenad Marjanovic", 
                                       email: "mr.nenad.marjanovic@gmail.com", 
                                       password: "nenad123", 
                                       password_confirmation: "nenad123"}}
    end
    follow_redirect!
    assert_template 'users/show'
  end
  
end
