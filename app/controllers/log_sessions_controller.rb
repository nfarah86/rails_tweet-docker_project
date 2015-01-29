class LogSessionsController < ApplicationController
  def new
  end

  def create
 	user = User.find_by(email: params[:session][:email].downcase)
 	if user && user.authenticate(params[:session][:password])
 		log_in user
 		redirect_to user
 	else
 		flash.now[:danger] = "Sorry, Password or Email is incorrect"
 		render 'new'
  	end

end
end
