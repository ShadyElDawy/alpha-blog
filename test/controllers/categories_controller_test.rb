require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest


	def setup
		@category = Category.create(name: "sports")
	end


	test "should get categories index" do

		get categories_path
		assert_response :success 

	end


	test "should get new" do

		get new_category_path
		assert_response :success

	end

	test "should get show" do #to generate a route for show we need an id for spicific category, hence we need to create one in setup method
		get category_path(@category)
		assert_response :success

	end



end