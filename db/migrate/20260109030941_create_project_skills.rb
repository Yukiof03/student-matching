class CreateProjectSkills < ActiveRecord::Migration[8.1]
  def change
    create_table :project_skills do |t|
      t.references :project, null: false
      t.references :skill, null: false, foreign_key: true
      t.string :required_level
      t.boolean :is_primary, default: false

      t.timestamps
    end

    add_index :project_skills, [:project_id, :skill_id], unique: true

    # Note: foreign_key for project will be added when projects table is created in Phase 3
  end
end
