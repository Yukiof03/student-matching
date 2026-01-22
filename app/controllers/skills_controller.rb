class SkillsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:autocomplete]

  def index
    @skills = Skill.order(:category, :name)
    @popular_skills = Skill.popular.limit(20)
  end

  def create
    # Allow users to create new skills
    @skill = Skill.find_or_create_by(name: skill_params[:name].strip.titleize) do |skill|
      skill.category = skill_params[:category] || 'other'
    end

    if @skill.persisted?
      # Add to user's skills if requested
      if params[:add_to_user] && current_user
        current_user.user_skills.find_or_create_by(skill: @skill)
      end

      render json: @skill, status: :created
    else
      render json: { errors: @skill.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def autocomplete
    # For dynamic tag input
    query = params[:q].to_s.strip
    @skills = Skill.where('name ILIKE ?', "%#{query}%")
                  .order(:name)
                  .limit(10)

    render json: @skills.map { |s| { id: s.id, name: s.name, category: s.category } }
  end

  private

  def skill_params
    params.require(:skill).permit(:name, :category)
  end
end
