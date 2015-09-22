require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
  test 'can authenticate' do
    visit signin_path

    fill_in :email, with: users(:admin).email
    fill_in :password, with: default_password
    click_on 'Sign in'

    assert_path events_path
    assert page.has_link?('Sign out', href: signout_path)
  end

  test 'failed authentication' do
    visit signin_path

    fill_in :email, with: users(:admin).email
    fill_in :password, with: 'wrong password'
    click_on 'Sign in'

    assert_path signin_path
    assert page.has_content?('Incorrect email or password.')
  end

  test 'can sign out' do
    login_as users(:admin)

    click_on 'Sign out'

    assert_path root_path
    refute page.has_content?('Sign out')
  end
end
