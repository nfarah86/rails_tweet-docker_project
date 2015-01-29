require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	test "user didn't sign up correctly" do
		get signup_path
			assert_no_difference "User.count" do
				post users_path, user:{
					name: "Global",
					email: "user@disneyland",
					password: "yo",
					password: "famo.us"
				}	
	end
	assert_template "users/new"
end

test "user signed up correctly" do
	get signup_path	
		assert_difference "User.count", 1 do
			post_via_redirect users_path, user:{
				name: "Mickey Mouse",
				email: "mickey@disneyland.com",
				password: "imCool",
				password_confirmation: "imCool"
			}
		end
	assert_template "users/show"
end

end
