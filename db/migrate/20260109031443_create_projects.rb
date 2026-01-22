class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.string :title, null: false
      t.text :purpose, null: false
      t.text :description
      t.integer :people_needed, default: 1
      t.string :estimated_period
      t.string :category, null: false
      t.string :status, default: 'draft'
      t.datetime :published_at

      t.timestamps
    end

    add_index :projects, :status
    add_index :projects, :category
    add_index :projects, :published_at

    # Add foreign key to project_skills that was deferred in Phase 2
    add_foreign_key :project_skills, :projects
  end
end
