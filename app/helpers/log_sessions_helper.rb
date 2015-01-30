module LogSessionsHelper

	def log_in(user)
		session[:user_id] = user.id
	end

	def current_user_in_session
		@current_user ||= User.find_by(id: session[:user_id])
		
		end

	def user_is_logged_in
		!current_user_in_session.nil?
	end

	def log_out
		session.delete(:user_id)
		@current_user = nil
	end

	def current_user?(user)
		user == current_user_in_session
	end

	def store_location
		session[:forwarding_url] = request.url if request.get?
	end

	def redirect_user(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end


end
