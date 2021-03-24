require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  # test 'some random' do
  #   assert true
  # end
  def setup
    @category = Category.create(name: 'sports')
    @user = User.create(username: 'admin', email: 'admin@xyz.com', password: 'admin', admin: true)
  end

  test "not allow to create new categories if not admin" do
    assert_no_difference 'Category.count' do
      post categories_path, params: {
        category: {
          name: "sports"
        }
      }
    end
    # follow_redirect! not nessory, as i am trying to see if redirected
    assert_redirected_to categories_path
  end

  test 'get route for category index' do
    get categories_path
    assert_response :success
  end

  test 'get route to create category' do
    sign_in_as(@user, 'admin')
    get new_category_path
    assert_response :success
    session[:user_id] = nil
    puts session
  end

  test 'get route to show category' do
    get category_path(@category)
    assert_response :success
  end
end