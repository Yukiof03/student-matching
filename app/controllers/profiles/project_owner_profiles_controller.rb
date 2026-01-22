class Profiles::ProjectOwnerProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to root_path, notice: 'プロフィールを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = current_user.project_owner_profile
  end

  def profile_params
    params.require(:project_owner_profile).permit(:introduction, :goals, :past_projects)
  end
end
