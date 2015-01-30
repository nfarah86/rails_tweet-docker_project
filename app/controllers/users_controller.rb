class UsersController < ApplicationController
  def show
 	@user = User.find(params[:id])
  end
  
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_attributes)
  	if @user.save
      log_in @user
  		flash[:success] = "Welcome " + "#{@user.name}" + "!"
  		redirect_to @user
  	
  	else
  		render 'new'
  	end
  end


  def edit
    @user = User.find(params[:id])
  end
  
  private
  	def user_attributes
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end


end
