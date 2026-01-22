class UserSkillsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user_skill = current_user.user_skills.build(user_skill_params)

    if @user_skill.save
      redirect_to root_path, notice: 'スキルを追加しました'
    else
      redirect_to root_path, alert: 'スキルの追加に失敗しました'
    end
  end

  def destroy
    @user_skill = current_user.user_skills.find(params[:id])
    @user_skill.destroy
    redirect_to root_path, notice: 'スキルを削除しました'
  end

  private

  def user_skill_params
    params.require(:user_skill).permit(:skill_id)
  end
end
