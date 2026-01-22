class ApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_application, only: [:show, :accept, :reject]

  def index
    # Show my applications (when in skill holder mode)
    @my_applications = current_user.applications.includes(:project).order(created_at: :desc)
    # Show applications to my projects (when in project owner mode)
    @received_applications = Application.joins(:project).where(projects: { owner_id: current_user.id }).includes(:project, :applicant).order(created_at: :desc)
  end

  def show
  end

  def create
    @project = Project.find(params[:project_id])

    # 公開されているプロジェクトのみ応募可能
    unless @project.active?
      redirect_to @project, alert: 'このプロジェクトには応募できません' and return
    end

    # 既存の応募をチェック
    existing_application = Application.find_by(project: @project, applicant: current_user)
    if existing_application
      redirect_to @project, alert: '既に応募済みです' and return
    end

    # 既存のマッチをチェック
    if Match.exists?(project: @project, matched_user: current_user)
      redirect_to @project, alert: '既にマッチング済みです' and return
    end

    @application = Application.new(
      project: @project,
      applicant: current_user,
      message: params[:message],
      status: 'pending'
    )

    if @application.save
      redirect_to @project, notice: 'プロジェクトに応募しました'
    else
      redirect_to @project, alert: '応募に失敗しました'
    end
  end

  def accept
    # プロジェクトオーナーのみ承認可能
    unless @application.project.owner == current_user
      redirect_to root_path, alert: 'この操作を行う権限がありません' and return
    end

    match_created = false
    match = nil
    ActiveRecord::Base.transaction do
      @application.update!(status: 'accepted')
      match = @application.check_and_create_match
      match_created = match.present?
    end

    if match_created
      redirect_to @application.project, notice: 'マッチングが成立しました！お互いのSNS情報が表示されます。'
    else
      redirect_to @application.project, notice: '応募を承認しました'
    end
  rescue => e
    Rails.logger.error("Application accept error: #{e.message}")
    Rails.logger.error(e.backtrace.join("\n"))
    redirect_to @application.project, alert: '応募の承認に失敗しました'
  end

  def reject
    # プロジェクトオーナーのみ却下可能
    unless @application.project.owner == current_user
      redirect_to root_path, alert: 'この操作を行う権限がありません' and return
    end

    @application.update!(status: 'rejected')
    redirect_to @application.project, notice: '応募を却下しました'
  rescue => e
    redirect_to @application.project, alert: '応募の却下に失敗しました'
  end

  private

  def set_application
    @application = Application.find(params[:id])
  end
end
