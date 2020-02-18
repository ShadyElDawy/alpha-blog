class ApplicationController < ActionController::Base
	helper_method :current_user, :logged_in?

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id] #if there is a user backed by browser, look for this user id in database and return it.
		# ||= is for return current user or find it ||=
	end

	def logged_in? #to see that current_user method is true or not
		!!current_user #return true if i have a current user 

	end

	def require_user #for certain action i want to restrict based on there is a logged in user or not 
		if !logged_in?
			flash[:danger] = "You must be logged in to perform this action"
			redirect_to root_path

		end

	end




end
