class PagesController < ApplicationController
	def home
		redirect_to articles_path if logged_in? #if user is logged in, my root is articles page
	end

	def about
	 
	end
end
