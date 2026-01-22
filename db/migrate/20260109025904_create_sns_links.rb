class CreateSnsLinks < ActiveRecord::Migration[8.1]
  def change
    create_table :sns_links do |t|
      t.references :user, null: false, foreign_key: true
      t.string :platform, null: false
      t.string :url, null: false
      t.boolean :visible_after_match, default: true

      t.timestamps
    end

    add_index :sns_links, [:user_id, :platform], unique: true
  end
end
