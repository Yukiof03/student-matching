class Match < ApplicationRecord
  belongs_to :project
  belongs_to :scout, optional: true
  belongs_to :application, optional: true
  belongs_to :matched_user, class_name: 'User'

  STATUSES = %w[active completed cancelled].freeze

  validates :status, inclusion: { in: STATUSES }
  validates :matched_user_id, uniqueness: { scope: :project_id }

  scope :active, -> { where(status: 'active') }
  scope :recent, -> { order(matched_at: :desc) }

  # Get SNS links for matched user (only visible after match)
  def revealed_sns_links
    matched_user.sns_links.where(visible_after_match: true)
  end
end
