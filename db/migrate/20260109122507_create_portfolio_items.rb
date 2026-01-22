class CreatePortfolioItems < ActiveRecord::Migration[8.1]
  def change
    create_table :portfolio_items do |t|
      t.references :skill_holder_profile, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :url
      t.date :completed_at
      t.integer :display_order

      t.timestamps
    end
  end
end
