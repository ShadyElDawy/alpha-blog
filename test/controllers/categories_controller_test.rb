require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest


	def setup
		@category = Category.create(name: "sports")
		@user = User.create(username: "john", email: "john@gmail.com", password: "password", admin: true)
	end


	test "should get categories index" do

		get categories_path
		assert_response :success 

	end


	test "should get new" do
		sign_in_as(@user, "password")
		get new_category_path
		assert_response :success

	end

	test "should get show" do #to generate a route for show we need an id for spicific category, hence we need to create one in setup method
		get category_path(@category)
		assert_response :success

	end

	test "should redirect create when admin not logged in" do
		assert_no_difference 'Category.count' do
			post categories_path, params: {category: {name: "sports"}} #post to the create action the category sports
		end
		assert_redirected_to categories_path  #here we don't have a logged in user, so when he try to post a category he should be redirected
		# the result is failing he succeded to post a category and he didn't get redirected
	end



end