class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
    @query = params[:q].to_s.strip
    @skill_ids = params[:skill_ids].present? ? params[:skill_ids].split(',').map(&:to_i) : []
    @category = params[:category]

    if project_owner_mode?
      # プロジェクトオーナーモード: スキルホルダーを検索
      search_skill_holders
    else
      # スキルホルダーモード: プロジェクトを検索
      search_projects
    end
  end

  private

  def search_skill_holders
    # スキルホルダープロフィールを持つユーザーを検索
    @users = User.joins(:skill_holder_profile)
                 .includes(:skills, :skill_holder_profile)
                 .distinct

    # キーワード検索（名前、自己紹介、実績）
    if @query.present?
      @users = @users.where(
        'users.name ILIKE :query OR
         skill_holder_profiles.introduction ILIKE :query OR
         skill_holder_profiles.past_work ILIKE :query OR
         skill_holder_profiles.achievements ILIKE :query',
        query: "%#{@query}%"
      )
    end

    # スキルフィルター
    if @skill_ids.any?
      @skill_ids.each do |skill_id|
        @users = @users.where(
          id: User.joins(:user_skills).where(user_skills: { skill_id: skill_id }).select(:id)
        )
      end
    end

    @users = @users.page(params[:page]).per(12)
    @selected_skills = Skill.where(id: @skill_ids)
  end

  def search_projects
    # 公開中のプロジェクトを検索
    @projects = Project.published
                       .includes(:owner, :skills)
                       .order(published_at: :desc)

    # キーワード検索（タイトル、目的、説明）
    if @query.present?
      @projects = @projects.where(
        'title ILIKE :query OR purpose ILIKE :query OR description ILIKE :query',
        query: "%#{@query}%"
      )
    end

    # カテゴリフィルター
    if @category.present?
      @projects = @projects.by_category(@category)
    end

    # スキルフィルター
    if @skill_ids.any?
      @skill_ids.each do |skill_id|
        @projects = @projects.where(
          id: Project.joins(:project_skills).where(project_skills: { skill_id: skill_id }).select(:id)
        )
      end
    end

    @projects = @projects.page(params[:page]).per(12)
    @selected_skills = Skill.where(id: @skill_ids)
  end
end
