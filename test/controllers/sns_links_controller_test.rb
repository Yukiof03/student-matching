require "test_helper"

class SnsLinksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sns_links_index_url
    assert_response :success
  end

  test "should get create" do
    get sns_links_create_url
    assert_response :success
  end

  test "should get destroy" do
    get sns_links_destroy_url
    assert_response :success
  end
end
