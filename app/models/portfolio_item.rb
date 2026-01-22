class PortfolioItem < ApplicationRecord
  belongs_to :skill_holder_profile

  # Active Storage attachments
  has_one_attached :image

  # Validations
  validates :title, presence: true

  # Scopes
  default_scope -> { order(display_order: :asc, created_at: :desc) }
end
