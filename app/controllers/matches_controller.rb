class MatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_match, only: [:show]

  def index
    @matches = current_user.matches.includes(:project, :matched_user).recent
  end

  def show
    # SNS links are revealed after match
    @revealed_sns_links = @match.revealed_sns_links
  end

  private

  def set_match
    @match = current_user.matches.find(params[:id])
  end
end
