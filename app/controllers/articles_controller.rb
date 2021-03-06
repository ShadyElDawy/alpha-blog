class ArticlesController < ApplicationController 
	before_action :set_article, only: [:edit, :update, :show, :destroy] #reduce code redundancy
	before_action :require_user, except: [:index, :show] #allow logged in user to edit articles through url
	before_action :require_same_user, only: [:edit, :update, :destroy] #allow logged in user to edit only his own article not all as above


	def new
		@article = Article.new

	end

	def index
		@articles = Article.paginate(page: params[:page], per_page: 5)
	end

	def edit #edit article

	end

	def create

		@article = Article.new(article_params) #every time article is created, all parameters from submission form is attached to this article (title and desc and array of categories)
		@article.user = current_user #the logged in user is attached to the new article he creates
		if @article.save
			flash[:success] = "Article was saved succefully"
			redirect_to article_path(@article)
		
		else
			render 'new'
		end 
	end

	def update #submission of the edit
		
		if @article.update(article_params)
			flash[:success] = "Article was succefully updated"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def show
		
	end

	def destroy
		
		@article.destroy
		flash[:danger] = "Article was succefully destroyed"
		redirect_to articles_path
	end

	private
		def set_article
			@article = Article.find(params[:id])
		end
		def article_params
			params.require(:article).permit(:title, :description, category_ids: []) #to send submission of checkbox categories we have to send an array of checked categories
		end

		def require_same_user #checks if user is not the owner of the article nor an admin
			if current_user != @article.user and !current_user.admin? #current user is grapped from the previous excustion of before action, order is important, and @article.user is from the first one
				flash[:danger] = "You can only edit or delete your own articles"
				redirect_to root_path	
			end
		end
end
