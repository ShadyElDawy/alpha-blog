class SessionsController < ApplicationController 

	
	
	def new  #render a form
	end
 
	def create  #handle submission of login, start session, display user in logged in state
		user = User.find_by(email: params[:session][:email].downcase) #params[:session][:email] => email that user entered
		if user && user.authenticate(params[:session][:password]) #if above is true and params[:session][:password] => password that user entered matches
		session[:user_id] = user.id #saving user id in session by browser cookies to simulate the user is logged in 
		flash[:success] = "You have succefully logged in"
		redirect_to user_path(user) #send the (user who signed in) to his show page
		else
			flash.now[:danger] = "there was something wrong with your login info" #flash now => display message only in current page not the next 
			render 'new'

		end

		
	end

	def destroy
		session[:user_id] = nil
		flash[:success] = "You have been logged out succefully"
		redirect_to root_path

	end

	

	private
	def user_params
		params.require(:user).permit(:username, :email, :password)
	end
end
 

