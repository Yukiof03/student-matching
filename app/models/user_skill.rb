class UserSkill < ApplicationRecord
  belongs_to :user
  belongs_to :skill, counter_cache: :usage_count

  validates :skill_id, uniqueness: { scope: :user_id }
  validates :proficiency_level, inclusion: { in: %w[beginner intermediate advanced expert] }, allow_nil: true
end
