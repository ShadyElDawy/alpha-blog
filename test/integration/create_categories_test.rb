require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

	
    def setup
        @user = User.create(username: "John", email: "john@example.com", password: "password", admin: true)
    end

	test "get new category form and create category" do
		sign_in_as(@user, "password")
		get new_category_path 
		assert_template 'categories/new' #getting the new form
		assert_difference 'Category.count', 1 do #posting to the new form creating a new sports category
			post categories_path, params: {category: {name: "sports"}}
			follow_redirect!
		end
		assert_template 'categories/index' #where do we send the user after this category is created
		assert_match "sports", response.body #to ensure that this category has been created
	end


	test "invalid category submission results in failure" do
		sign_in_as(@user, "password")
		get new_category_path 
		assert_template 'categories/new' #getting the new form
		assert_no_difference 'Category.count' do #posting to the new form creating a new sports category
			post categories_path, params: {category: {name: " "}}
			
		end
		assert_template 'categories/new' #where do we send the user after this category is created
		assert_select 'h2.panel-title' # looking for the exitence of these 2 things (below also)
		assert_select 'div.panel-body' # if these 2 showed up i know that my errors partial is being rendered 
	end


end