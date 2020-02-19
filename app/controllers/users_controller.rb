class UsersController < ApplicationController 

	before_action :set_user, only: [:edit, :update, :show]  #reduce code redundancy
	#following methods to prevent actions through url for unauthenticated users
	before_action :require_same_user, only: [:edit, :update, :destroy] #allow logged in user to edit only his own profile
	before_action :require_admin, only: [:destroy] #only admin can delete users

	def index
		@users = User.paginate(page: params[:page], per_page: 5)

	end
	
	def new
		@user = User.new
	end

	def create 
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id #to keep user logged in after signing up
			flash[:success] = "Welcome to the Alpha Blog #{@user.username}"
			redirect_to user_path(@user)
		else
			render 'new'
		end
	end

	def edit
		

	end

	def update 
		
		if @user.update(user_params)
			flash[:success] = "user info was succefully updated"
			redirect_to articles_path
		else
			render 'edit'
		end

	end
	def show
		
		@user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		flash[:danger] = "User and all articles created by user has been deleted"
		redirect_to users_path
	end

	private
	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	def set_user
		@user = User.find(params[:id])
	end

	def require_same_user
			if current_user != @user and !current_user.admin? #if he is not the admin nor the user that is logged in
				flash[:danger] = "You can only edit your own account"
				redirect_to root_path	
			end
	end

	def require_admin
		if logged_in? and !current_user.admin? #if he is logged in but he is not the admin
			flash[:danger] = "only admin can perform that action"
			redirect_to root_path
		end		
	end
end
 

