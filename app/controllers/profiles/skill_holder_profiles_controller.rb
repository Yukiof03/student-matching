class Profiles::SkillHolderProfilesController < ApplicationController
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
    @profile = current_user.skill_holder_profile
  end

  def profile_params
    params.require(:skill_holder_profile).permit(:introduction, :past_work, :achievements, :availability)
  end
end
