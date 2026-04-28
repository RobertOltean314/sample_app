require 'test_helper'

class UsersLogin < ActionDispatch::IntegrationTest
  def setup
    @user = users(:robert)
  end
end

class InvalidPasswordTest < UsersLogin
  test 'login path' do
    get login_path
    assert_response :success
    assert_template 'sessions/new'
  end

  test 'login with wrong password' do
    post login_path, params: { session: { email: @user.email, password: 'foo' } }
    assert_not logged_in?
    assert_response :unprocessable_entity
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end

class ValidLogin < UsersLogin
  def setup
    super
    post login_path, params: { session: { email: @user.email, password: 'parola1234' } }
  end
end

class ValidLoginTest < ValidLogin
  test 'valid login' do
    assert logged_in?
    assert_redirected_to @user
  end

  test 'follow redirect after login' do
    follow_redirect!
    assert_response :ok
    assert_template 'users/show'
  end
end

class Logout < ValidLogin
  def setup
    super
    delete logout_path
  end
end

class LogoutTest < Logout
  test 'logout' do
    assert_not logged_in?
    assert_response :see_other
    assert_redirected_to root_url
  end

  test 'follow redirect after logout' do
    follow_redirect!
    assert_response :ok
  end
end
