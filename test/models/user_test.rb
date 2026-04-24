require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Example User', email: 'example@gmail.com', password: 'foobar123',
                     password_confirmation: 'foobar123')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'should have name' do
    @user.name = ' '
    assert_not @user.valid?
  end

  test 'should have email' do
    @user.email = ' '
    assert_not @user.valid?
  end

  test 'name should not be to long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be to long' do
    @user.email = 'a' * 151
    assert_not @user.valid?
  end

  test 'email validation should acceppt only supported emails' do
    valid_addresses = %w[user@example.com USER@foo.COM A_USER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]

    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test 'email validation should reject unsupported email' do
    invalid_addresses = %w[user@example,com USER@foo,COM A_USER@foo,bar,org
                           first,last@foo,jp alice+bob@baz,cn]

    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test 'email address should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email should be saved lowercase' do
    mixed_case_email = 'EXAMPLE@GMAIL.COM'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
end
