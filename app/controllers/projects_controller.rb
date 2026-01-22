class ProjectsController < ApplicationController
  before_action :require_project_owner_mode, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_project, only: [:show, :edit, :update, :destroy, :publish]
  before_action :authorize_owner, only: [:edit, :update, :destroy, :publish]

  def index
    @projects = Project.published
                      .includes(:owner, :skills)
                      .by_category(params[:category])
                      .page(params[:page])
                      .per(12)
  end

  def show
    @required_skills = @project.skills
    @can_apply = skill_holder_mode? # Will be used in Phase 5 for applications
  end

  def new
    @project = current_user.projects.build
    @all_skills = Skill.order(:name)
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      attach_skills(@project, params[:skill_ids]) if params[:skill_ids].present?
      redirect_to @project, notice: 'プロジェクトを作成しました'
    else
      @all_skills = Skill.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @all_skills = Skill.order(:name)
  end

  def update
    if @project.update(project_params)
      # Update skills
      @project.project_skills.destroy_all
      attach_skills(@project, params[:skill_ids]) if params[:skill_ids].present?
      redirect_to @project, notice: 'プロジェクトを更新しました'
    else
      @all_skills = Skill.order(:name)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'プロジェクトを削除しました'
  end

  def publish
    if @project.publish!
      redirect_to @project, notice: 'プロジェクトを公開しました'
    else
      redirect_to @project, alert: 'プロジェクトの公開に失敗しました'
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def authorize_owner
    unless @project.owner == current_user
      redirect_to projects_path, alert: '権限がありません'
    end
  end

  def require_project_owner_mode
    unless project_owner_mode?
      redirect_to root_path, alert: 'プロジェクトを作成するにはプロジェクトオーナーモードに切り替えてください'
    end
  end

  def attach_skills(project, skill_ids)
    return if skill_ids.blank?

    skill_ids = JSON.parse(skill_ids) if skill_ids.is_a?(String)

    skill_ids.each do |skill_id|
      project.project_skills.create(skill_id: skill_id)
    end
  end

  def project_params
    params.require(:project).permit(:title, :purpose, :description,
                                   :people_needed, :estimated_period, :category)
  end
end
