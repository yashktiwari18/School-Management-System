require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    login_as(admins(:one))

      get dashboard_path
    assert_response :success
  end
end
