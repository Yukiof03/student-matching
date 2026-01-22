class Application < ApplicationRecord
  belongs_to :project
  belongs_to :applicant, class_name: 'User'

  STATUSES = %w[pending accepted rejected cancelled].freeze

  validates :status, inclusion: { in: STATUSES }
  validates :applicant_id, uniqueness: { scope: :project_id }

  scope :pending, -> { where(status: 'pending') }
  scope :accepted, -> { where(status: 'accepted') }
  scope :recent, -> { order(created_at: :desc) }

  # Check if there's a corresponding scout
  def has_matching_scout?
    Scout.exists?(
      project_id: project_id,
      scouted_user_id: applicant_id,
      status: 'accepted'
    )
  end

  # Create match if both application and scout are accepted
  def check_and_create_match
    return unless status == 'accepted'
    return if Match.exists?(project_id: project_id, matched_user_id: applicant_id)

    scout = Scout.find_by(
      project_id: project_id,
      scouted_user_id: applicant_id,
      status: 'accepted'
    )

    if scout
      Match.create!(
        project: project,
        scout: scout,
        application: self,
        matched_user_id: applicant_id,
        matched_at: Time.current
      )
    end
  end
end
