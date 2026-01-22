class CreateProjectOwnerProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :project_owner_profiles do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.text :introduction
      t.text :goals
      t.text :past_projects

      t.timestamps
    end
  end
end
