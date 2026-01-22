class Scout < ApplicationRecord
  belongs_to :project
  belongs_to :scout_user, class_name: 'User'
  belongs_to :scouted_user, class_name: 'User'

  STATUSES = %w[pending accepted rejected cancelled].freeze

  validates :status, inclusion: { in: STATUSES }
  validates :scouted_user_id, uniqueness: { scope: :project_id }

  scope :pending, -> { where(status: 'pending') }
  scope :accepted, -> { where(status: 'accepted') }
  scope :recent, -> { order(created_at: :desc) }

  # Check if there's a corresponding application
  def has_matching_application?
    Application.exists?(
      project_id: project_id,
      applicant_id: scouted_user_id,
      status: 'accepted'
    )
  end

  # Create match if both scout and application are accepted
  def check_and_create_match
    return unless status == 'accepted'
    return if Match.exists?(project_id: project_id, matched_user_id: scouted_user_id)

    application = Application.find_by(
      project_id: project_id,
      applicant_id: scouted_user_id,
      status: 'accepted'
    )

    if application
      Match.create!(
        project: project,
        scout: self,
        application: application,
        matched_user_id: scouted_user_id,
        matched_at: Time.current
      )
    end
  end
end
