class CreateMatches < ActiveRecord::Migration[8.1]
  def change
    create_table :matches do |t|
      t.references :project, null: false, foreign_key: true
      t.references :scout, foreign_key: true
      t.references :application, foreign_key: true
      t.references :matched_user, null: false, foreign_key: { to_table: :users }
      t.string :status, null: false, default: 'active'
      t.datetime :matched_at, null: false

      t.timestamps
    end

    add_index :matches, [:project_id, :matched_user_id], unique: true
    add_index :matches, :status
  end
end
