class SkillHolderProfile < ApplicationRecord
  belongs_to :user
  has_many :portfolio_items, dependent: :destroy

  validates :user, uniqueness: true
end
