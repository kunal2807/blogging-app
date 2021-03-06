require 'test_helper'

class CreateCategories < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'admin', email: 'admin@xyz.com', password: 'admin', admin: true)
  end

  test 'get new category form and create it' do
    sign_in_as(@user, 'admin')
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post categories_path, params: {
        category: {
          name: "sports"
        }
      }
    end
    follow_redirect!
    assert_template 'categories/index'
    assert_match "sports", response.body
  end

  test "invalid category entry" do
    sign_in_as(@user, 'admin')
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, params: {
        category: {
          name: ""
        }
      }
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

  
end