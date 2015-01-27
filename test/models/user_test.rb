require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	
  	#create a User object
  	@user = User.new(name: "ExampleUser", email: "user@gmail.com",
  						password:"foobar", password_confirmation: "foobar")
	end

	#test to see if User object is valid
	test "should be valid" do 
		assert @user.valid?
	end

	#test user name and email are valid before being saved to db
	test "name should be present" do
		@user.name = "   "
		assert_not @user.valid?
	end
	#testing to see if email is present, if blank = false 
	test "email should be present" do 
		@user.email = "  "
		assert_not @user.valid?
	end

	#checking character length; >50 = false
	test "name should not be long" do
		@user.name = "a" * 51
		assert_not @user.valid?
	end

	#testing length 'prefix' @gmail.com length; > 244 = false
	test "email should not be too long" do
		@user.email = "a" * 244 + "@gmail.com"
	end

	#valid email addresses should be accepted
	test "email validation should accept valid addresses" do
		valid_addresses = %w[user@example.com User@foo.COM A_us-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?, "#{valid_address.inspect} should be valid"
		end
	end


 	test "email validation should reject invalid addresses" do
	    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
	                           foo@bar_baz.com foo@bar+baz.com foo@bar....com]
	    invalid_addresses.each do |invalid_address|
	      @user.email = invalid_address
	      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
	    end
  	end

	test "email addresses should be unique" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
	end

	test "email addresses should be saved as lower-case" do
		mixed_case_email = "FoO@examPLE.cOM"
		@user.email = mixed_case_email
		@user.save
		assert_equal mixed_case_email.downcase, @user.reload.email
	end


	test "password should have a minimum length" do
		@user.password = @user.password_confirmation = "a" * 5
		assert_not @user.valid?
	end
	

end



