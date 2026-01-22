require "test_helper"

class ScoutsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get scouts_create_url
    assert_response :success
  end

  test "should get accept" do
    get scouts_accept_url
    assert_response :success
  end

  test "should get reject" do
    get scouts_reject_url
    assert_response :success
  end
end
