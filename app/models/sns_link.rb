class SnsLink < ApplicationRecord
  belongs_to :user

  # Common platforms for student collaboration
  PLATFORMS = %w[Twitter Instagram Facebook Discord Slack LINE Email Other].freeze

  validates :platform, presence: true, inclusion: { in: PLATFORMS }
  validates :url, presence: true
  validates :platform, uniqueness: { scope: :user_id, message: "already exists for this user" }
end
