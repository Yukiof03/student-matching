class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Profile associations
  has_one :project_owner_profile, dependent: :destroy
  has_one :skill_holder_profile, dependent: :destroy

  # SNS URLs
  has_many :sns_links, dependent: :destroy

  # Skills (for skill holder mode)
  has_many :user_skills, dependent: :destroy
  has_many :skills, through: :user_skills

  # Projects (when acting as project owner)
  has_many :projects, foreign_key: :owner_id, dependent: :destroy

  # Scouts and Applications
  has_many :sent_scouts, class_name: 'Scout', foreign_key: :scout_user_id, dependent: :destroy
  has_many :received_scouts, class_name: 'Scout', foreign_key: :scouted_user_id, dependent: :destroy
  has_many :applications, foreign_key: :applicant_id, dependent: :destroy

  # Matches
  has_many :matches, foreign_key: :matched_user_id, dependent: :destroy

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  # Build profiles after user creation
  after_create :create_default_profiles

  private

  def create_default_profiles
    create_project_owner_profile unless project_owner_profile
    create_skill_holder_profile unless skill_holder_profile
  end
end
