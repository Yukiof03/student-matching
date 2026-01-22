require "test_helper"

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get applications_create_url
    assert_response :success
  end

  test "should get accept" do
    get applications_accept_url
    assert_response :success
  end

  test "should get reject" do
    get applications_reject_url
    assert_response :success
  end
end
