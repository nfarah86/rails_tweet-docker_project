require 'test_helper'

class LoginSessionsTest < ActionDispatch::IntegrationTest
  
def setup

 test "login with invalid information" do
    get login_path
    assert_template 'log_sessions/new'
    post login_path, session: { email: " ", password: "" }
    assert_template 'log_sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end



