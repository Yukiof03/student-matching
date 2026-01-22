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
      # 双方向のMatchレコードを作成
      ActiveRecord::Base.transaction do
        owner_id = project.owner_id

        # スキルホルダー用のMatchレコード
        match_for_holder = Match.create!(
          project: project,
          scout: scout,
          application: self,
          matched_user_id: applicant_id,  # スキルホルダー
          matched_at: Time.current
        )

        # プロジェクトオーナー用のMatchレコード
        Match.create!(
          project: project,
          scout: scout,
          application: self,
          matched_user_id: owner_id,  # プロジェクトオーナー
          matched_at: Time.current
        )

        match_for_holder
      end
    end
  end
end
