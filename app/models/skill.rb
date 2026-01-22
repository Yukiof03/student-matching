class Skill < ApplicationRecord
  has_many :user_skills, dependent: :destroy
  has_many :users, through: :user_skills
  has_many :project_skills, dependent: :destroy
  has_many :projects, through: :project_skills

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  scope :popular, -> { order(usage_count: :desc) }
  scope :by_category, ->(category) { where(category: category) if category.present? }

  # Normalize skill name before save
  before_save :normalize_name

  private

  def normalize_name
    self.name = name.strip.titleize if name.present?
  end
end
