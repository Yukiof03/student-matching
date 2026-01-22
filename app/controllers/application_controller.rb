class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :set_current_mode

  helper_method :current_mode, :project_owner_mode?, :skill_holder_mode?

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
end
