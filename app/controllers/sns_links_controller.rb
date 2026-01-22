class SnsLinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sns_link, only: [:destroy]

  def index
    @sns_links = current_user.sns_links
    @sns_link = SnsLink.new
  end

  def create
    @sns_link = current_user.sns_links.build(sns_link_params)

    if @sns_link.save
      redirect_to sns_links_path, notice: 'SNSリンクを追加しました'
    else
      @sns_links = current_user.sns_links.reload
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @sns_link.destroy
    redirect_to sns_links_path, notice: 'SNSリンクを削除しました'
  end

  private

  def set_sns_link
    @sns_link = current_user.sns_links.find(params[:id])
  end

  def sns_link_params
    params.require(:sns_link).permit(:platform, :url, :visible_after_match)
  end
end
