require "test_helper"

class Profiles::SkillHolderProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get profiles_skill_holder_profiles_edit_url
    assert_response :success
  end

  test "should get update" do
    get profiles_skill_holder_profiles_update_url
    assert_response :success
  end
end
