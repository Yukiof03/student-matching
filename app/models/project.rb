class Project < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :project_skills, dependent: :destroy
  has_many :skills, through: :project_skills

  # Matching associations - matches must be deleted before scouts/applications
  has_many :matches, dependent: :destroy
  has_many :scouts, dependent: :destroy
  has_many :applications, dependent: :destroy

  CATEGORIES = %w[web mobile ai design video music business education other].freeze
  STATUSES = %w[draft active paused closed].freeze

  validates :title, presence: true
  validates :purpose, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :people_needed, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: STATUSES }

  scope :active, -> { where(status: 'active') }
  scope :by_category, ->(category) { where(category: category) if category.present? }
  scope :recent, -> { order(created_at: :desc) }
  scope :published, -> { where.not(published_at: nil).where(status: 'active') }

  def publish!
    update!(status: 'active', published_at: Time.current)
  end

  def draft?
    status == 'draft'
  end

  def active?
    status == 'active'
  end
end
