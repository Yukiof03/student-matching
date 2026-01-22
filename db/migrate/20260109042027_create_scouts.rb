class CreateScouts < ActiveRecord::Migration[8.1]
  def change
    create_table :scouts do |t|
      t.references :project, null: false, foreign_key: true
      t.references :scout_user, null: false, foreign_key: { to_table: :users }
      t.references :scouted_user, null: false, foreign_key: { to_table: :users }
      t.string :status, null: false, default: 'pending'
      t.text :message

      t.timestamps
    end

    add_index :scouts, [:project_id, :scouted_user_id], unique: true
    add_index :scouts, :status
  end
end
