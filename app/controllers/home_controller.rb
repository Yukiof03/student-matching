class HomeController < ApplicationController
  def index
    @user = current_user
    @project_owner_profile = @user.project_owner_profile
    @skill_holder_profile = @user.skill_holder_profile

    # Initialize recommendation service
    @recommendation_service = RecommendationService.new(@user)

    # Get recommendations based on current mode
    if project_owner_mode?
      @recommended_skill_holders = @recommendation_service.recommended_skill_holders_for_all_projects(limit: 5)
    else
      @recommended_projects = @recommendation_service.recommended_projects(limit: 5)
      @recent_projects = @recommendation_service.recent_projects(limit: 5)
    end
  end

  def switch_mode
    new_mode = params[:mode]
    switch_to_mode(new_mode)
    redirect_to root_path, notice: "#{new_mode == 'project_owner' ? 'プロジェクトオーナー' : 'スキルホルダー'}モードに切り替えました"
  end
end
