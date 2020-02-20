require "test_helper"

#whatever is here is not gonna hit developement database, but a test database

class CategoryTest < ActiveSupport::TestCase

	def setup  #runs before every one of my test
		@category = Category.new(name: "sports") #takes only one attribute which is name 

	end 

	test "category should be valid" do 
		#whatever is here is called assertion
		assert @category.valid? #look to see if above instance var is valid?
	end

#starting them in a failed state and then build validations

	test "name should be present" do
		@category.name = " "
		assert_not @category.valid?
	end

	test "name should be unique" do
		@category.save
		category2 = Category.new(name: "sports")
		assert_not category2.valid?
	end

	test "name should not be too long" do 
		@category.name = "a" * 26
		assert_not @category.valid?

	end

	test "name should not be too short" do
		@category.name = "aa"
		assert_not @category.valid?
	end
end