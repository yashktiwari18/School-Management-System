require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    login_as(admins(:one))

    get reports_path

    assert_response :success
  end
end
