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
    if session[:show_match_sns].present?
      partner_id = session[:show_match_sns]['partner_id']
      project_id = session[:show_match_sns]['project_id']

      @match_sns_data = {
        partner: User.find_by(id: partner_id),
        project: Project.find_by(id: project_id)
      }

      # セッションから削除（一度だけ表示）
      session.delete(:show_match_sns)
    end
  end

  def match_sns_data
    @match_sns_data
  end
end
