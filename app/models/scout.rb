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

  # Create match when scout is accepted
  def check_and_create_match
    return unless status == 'accepted'
    return if Match.exists?(project_id: project_id, matched_user_id: scouted_user_id)

    # 応募が存在するか確認（オプション）
    application = Application.find_by(
      project_id: project_id,
      applicant_id: scouted_user_id
    )

    # スカウトが承認されたらマッチング作成（応募の有無に関わらず）
    ActiveRecord::Base.transaction do
      owner_id = project.owner_id

      # スキルホルダー用のMatchレコード
      match_for_holder = Match.create!(
        project: project,
        scout: self,
        application: application,  # 応募がない場合はnil
        matched_user_id: scouted_user_id,  # スキルホルダー
        matched_at: Time.current
      )

      # プロジェクトオーナー用のMatchレコード
      Match.create!(
        project: project,
        scout: self,
        application: application,  # 応募がない場合はnil
        matched_user_id: owner_id,  # プロジェクトオーナー
        matched_at: Time.current
      )

      match_for_holder
    end
  end
end
