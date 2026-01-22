class ScoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_scout, only: [:show, :accept, :reject]

  def index
    # Show received scouts (when in skill holder mode)
    @received_scouts = current_user.received_scouts.includes(:project, :scout_user).order(created_at: :desc)
    # Show sent scouts (when in project owner mode)
    @sent_scouts = current_user.sent_scouts.includes(:project, :scouted_user).order(created_at: :desc)
  end

  def show
  end

  def create
    @project = Project.find(params[:project_id])
    @user = User.find(params[:user_id])

    # プロジェクトオーナーのみスカウト可能
    unless @project.owner == current_user
      redirect_to @project, alert: 'スカウトを送信する権限がありません' and return
    end

    # 既存のスカウトをチェック
    existing_scout = Scout.find_by(project: @project, scouted_user: @user)
    if existing_scout
      redirect_to @project, alert: '既にスカウトを送信済みです' and return
    end

    # 既存のマッチをチェック
    if Match.exists?(project: @project, matched_user: @user)
      redirect_to @project, alert: '既にマッチング済みです' and return
    end

    @scout = Scout.new(
      project: @project,
      scout_user: current_user,
      scouted_user: @user,
      message: params[:message],
      status: 'pending'
    )

    if @scout.save
      redirect_to search_path, notice: "#{@user.name}さんにスカウトを送信しました"
    else
      redirect_to search_path, alert: 'スカウトの送信に失敗しました'
    end
  end

  def accept
    unless @scout.scouted_user == current_user
      redirect_to root_path, alert: 'この操作を行う権限がありません' and return
    end

    match_created = false
    ActiveRecord::Base.transaction do
      @scout.update!(status: 'accepted')
      match = @scout.check_and_create_match
      match_created = match.present?
    end

    if match_created
      # マッチング成立時は、SNS情報表示用のフラッグをセッションに保存
      session[:show_match_sns] = {
        partner_id: @scout.scout_user.id,
        project_id: @scout.project.id
      }
      redirect_to root_path, notice: 'マッチングが成立しました！'
    else
      redirect_to root_path, notice: 'スカウトを承認しました'
    end
  rescue => e
    redirect_to root_path, alert: 'スカウトの承認に失敗しました'
  end

  def reject
    unless @scout.scouted_user == current_user
      redirect_to root_path, alert: 'この操作を行う権限がありません' and return
    end

    @scout.update!(status: 'rejected')
    redirect_to root_path, notice: 'スカウトを辞退しました'
  rescue => e
    redirect_to root_path, alert: 'スカウトの辞退に失敗しました'
  end

  private

  def set_scout
    @scout = Scout.find(params[:id])
  end
end
