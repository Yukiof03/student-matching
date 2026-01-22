class ProjectSkill < ApplicationRecord
  belongs_to :project
  belongs_to :skill

  validates :skill_id, uniqueness: { scope: :project_id }
  validates :required_level, inclusion: { in: %w[beginner intermediate advanced expert] }, allow_nil: true
end
