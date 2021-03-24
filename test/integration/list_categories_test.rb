require 'test_helper'

class ListCategories < ActionDispatch::IntegrationTest
  
  def setup
   @category = Category.create(name: 'sports')
   @category2 = Category.create(name: 'hacking')
  end
  
  test 'should show categories list' do
    get categories_path
    assert_template 'categories/index'
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end

  test "invalid category entry" do
    
  end

  
end