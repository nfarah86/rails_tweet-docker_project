class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

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


  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_attributes)
      flash[:success] = "RoboProfile updated"
      redirect_to @user
  else
    render 'edit'
  end
end
  private
  	def user_attributes
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    def logged_in_user
      unless user_is_logged_in
        store_location
        flash[:danger] = "Please RoboLog In "
        redirect_to login_url
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  end
  
end
