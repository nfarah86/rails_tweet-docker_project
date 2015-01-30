class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :current_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy



  def index
    @users = User.all
      # @users = User.paginate(:page => params[:page])
  end

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

    def admin_user
      redirect_to (root_url) unless current_user_in_session.admin?
    end
    def logged_in_user
      unless user_is_logged_in
        store_location
        flash[:danger] = "Please RoboLog In "
        redirect_to login_url
    end

    def current_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user == @user
    end


    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "You successfully deleted a RoboUser"
      redirect_to users_url
    end
  end
  
end
