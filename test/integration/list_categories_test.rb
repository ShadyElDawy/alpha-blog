require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest

	def setup #to create a couple of categories
		@category = Category.create(name: "sports")
		@category2 = Category.create(name: "programming")
	end

	test "should show categories listing" do
		get categories_path #rails routes --> to view all routes u need
		assert_template 'categories/index'
		assert_select "a[href=?]", category_path(@category), text: @category.name

	end

end