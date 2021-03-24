require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  # test 'some random' do
  #   assert true
  # end
  def setup
    @category = Category.create(name: 'sports')
  end

  test 'get route for category index' do
    get categories_path
    assert_response :success
  end

  test 'get route for category new' do
    get new_category_path
    assert_response :success
  end

  test 'get route for category show' do
    get category_path(@category)
    assert_response :success
  end
end