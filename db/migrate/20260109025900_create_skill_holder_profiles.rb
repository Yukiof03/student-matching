class CreateSkillHolderProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :skill_holder_profiles do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.text :introduction
      t.text :past_work
      t.text :achievements
      t.string :availability

      t.timestamps
    end
  end
end
