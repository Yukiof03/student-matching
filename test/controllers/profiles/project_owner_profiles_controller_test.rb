require "test_helper"

class Profiles::ProjectOwnerProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get profiles_project_owner_profiles_edit_url
    assert_response :success
  end

  test "should get update" do
    get profiles_project_owner_profiles_update_url
    assert_response :success
  end
end
