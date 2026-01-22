class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :set_current_mode
  before_action :check_match_sns_notification

  helper_method :current_mode, :project_owner_mode?, :skill_holder_mode?, :match_sns_data

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :bio])
  end

  def set_current_mode
    session[:current_mode] ||= 'project_owner'
  end

  def current_mode
    session[:current_mode]
  end

  def project_owner_mode?
    current_mode == 'project_owner'
  end

  def skill_holder_mode?
    current_mode == 'skill_holder'
  end

  def switch_to_mode(mode)
    if %w[project_owner skill_holder].include?(mode)
      session[:current_mode] = mode
    end
  end

  def check_match_sns_notification
    # 現在のセッションにマッチング通知があるかチェック
    if session[:show_match_sns].present?
      partner_id = session[:show_match_sns]['partner_id']
      project_id = session[:show_match_sns]['project_id']

      @match_sns_data = {
        partner: User.find_by(id: partner_id),
        project: Project.find_by(id: project_id)
      }

      # セッションから削除（一度だけ表示）
      session.delete(:show_match_sns)
    elsif current_user.present?
      # ユーザーごとの保存された通知をチェック
      check_stored_match_notification
    end
  end

  def match_sns_data
    @match_sns_data
  end

  # ユーザーごとのマッチング通知を保存（Redisやデータベースの代わりにセッションストアを使用）
  def store_match_notification_for_user(user_id, partner_id, project_id, match_id)
    # 簡易実装: Matchモデルに未読フラグを追加する代わりに、
    # セッションキーに基づいた一時的な保存を使用
    # 本番環境ではRedisやデータベースを使用することを推奨
    Rails.cache.write(
      "match_notification_#{user_id}_#{match_id}",
      {
        partner_id: partner_id,
        project_id: project_id,
        match_id: match_id
      },
      expires_in: 7.days
    )
  end

  # 保存されたマッチング通知をチェック
  def check_stored_match_notification
    return unless current_user

    # ユーザーの未読マッチングを探す
    Match.where(matched_user_id: current_user.id)
         .where('matched_at > ?', 7.days.ago)
         .order(matched_at: :desc)
         .each do |match|
      cache_key = "match_notification_#{current_user.id}_#{match.id}"
      notification = Rails.cache.read(cache_key)

      if notification.present?
        # 通知を表示
        @match_sns_data = {
          partner: User.find_by(id: notification[:partner_id]),
          project: Project.find_by(id: notification[:project_id])
        }

        # キャッシュから削除（一度だけ表示）
        Rails.cache.delete(cache_key)
        break  # 最初の通知のみ表示
      end
    end
  end
end
