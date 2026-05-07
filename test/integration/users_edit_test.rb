require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:robert)
    log_in_as(@user, remember_me: '1')
  end

  test 'unsuccessfull edit' do
    get edit_user_path(@user)

    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: '', email: '', password: 'foo', password_confirmation: 'bar' } }

    assert_template 'users/edit'
  end

  test 'succesfull edit' do
    get edit_user_path(@user)

    # assert_template 'users/edit'

    name = 'Foo bar'
    email = 'foo@bar.com'

    patch user_path(@user),
          params: { user: { name:, email:, password: '', password_confirmation: '' } }

    assert_not flash.empty?
    # assert_redirected_to @user
    @user.reload

    assert_equal name, @user.name
    assert_equal email, @user.email
  end

  test 'succesfull edit with friendly redirect' do
    get edit_user_path(@user)
    log_in_as(@user)

    # assert_redirected_to edit_user_url(@user)
    name = 'Foo Bar'
    email = 'foo@bar.com'
    patch user_path(@user), params: { user: { name:, email:, password: '', password_confirmation: '' } }

    assert_not flash.empty?
    # assert_redirected_to @user

    @user.reload

    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
