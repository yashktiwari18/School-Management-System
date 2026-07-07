require "test_helper"

class AdminProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_profiles_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_profiles_edit_url
    assert_response :success
  end
end
