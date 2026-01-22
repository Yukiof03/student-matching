class CreateApplications < ActiveRecord::Migration[8.1]
  def change
    create_table :applications do |t|
      t.references :project, null: false, foreign_key: true
      t.references :applicant, null: false, foreign_key: { to_table: :users }
      t.string :status, null: false, default: 'pending'
      t.text :message

      t.timestamps
    end

    add_index :applications, [:project_id, :applicant_id], unique: true
    add_index :applications, :status
  end
end
