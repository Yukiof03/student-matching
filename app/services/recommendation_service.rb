class RecommendationService
  def initialize(user)
    @user = user
  end

  # スキルホルダー向け: おすすめのプロジェクトを取得
  def recommended_projects(limit: 10)
    return Project.none if @user.skills.empty?

    # ユーザーが持っているスキルを必要としているプロジェクトを検索
    # スキルの一致数でランク付け
    Project.active
      .joins(:project_skills)
      .where(project_skills: { skill_id: @user.skill_ids })
      .where.not(owner_id: @user.id) # 自分のプロジェクトは除外
      .select('projects.*, COUNT(project_skills.id) as matching_skills_count')
      .group('projects.id')
      .order('matching_skills_count DESC, projects.created_at DESC')
      .limit(limit)
  end

  # プロジェクトオーナー向け: おすすめのスキルホルダーを取得
  def recommended_skill_holders(project, limit: 10)
    return User.none if project.skills.empty?

    # プロジェクトが必要としているスキルを持っているユーザーを検索
    # スキルの一致数でランク付け
    User.joins(:user_skills)
      .where(user_skills: { skill_id: project.skill_ids })
      .where.not(id: @user.id) # 自分自身は除外
      .select('users.*, COUNT(user_skills.id) as matching_skills_count')
      .group('users.id')
      .order('matching_skills_count DESC')
      .limit(limit)
  end

  # 全プロジェクトからおすすめのスキルホルダーを取得
  def recommended_skill_holders_for_all_projects(limit: 10)
    # ユーザーの全プロジェクトが必要としているスキルを集計
    project_skill_ids = @user.projects.active.joins(:project_skills).pluck('project_skills.skill_id').uniq

    return User.none if project_skill_ids.empty?

    User.joins(:user_skills)
      .where(user_skills: { skill_id: project_skill_ids })
      .where.not(id: @user.id)
      .select('users.*, COUNT(user_skills.id) as matching_skills_count')
      .group('users.id')
      .order('matching_skills_count DESC')
      .limit(limit)
  end

  # 新着プロジェクト（スキルホルダー向け）
  def recent_projects(limit: 5)
    Project.active
      .where.not(owner_id: @user.id)
      .order(created_at: :desc)
      .limit(limit)
  end

  # 人気のスキル（使用頻度が高いスキル）
  def self.popular_skills(limit: 10)
    Skill.joins(:user_skills)
      .select('skills.*, COUNT(user_skills.id) as users_count')
      .group('skills.id')
      .order('users_count DESC')
      .limit(limit)
  end

  # プロジェクトで人気のスキル
  def self.popular_project_skills(limit: 10)
    Skill.joins(:project_skills)
      .select('skills.*, COUNT(project_skills.id) as projects_count')
      .group('skills.id')
      .order('projects_count DESC')
      .limit(limit)
  end
end
