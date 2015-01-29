module LogSessionsHelper

	def log_in(user)
		session[:user_id] = user.id
	end

	def current_user_in_session
		if @current_user.nil?
			@current_user = User.find_by(id: session[:user_id])
		else
			@current_user
		end
	end
end
