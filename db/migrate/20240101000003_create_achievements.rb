class CreateAchievements < ActiveRecord::Migration[8.1]
  def change
    create_table :achievements do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :icon, null: false
      t.string :condition_type, null: false
      t.integer :condition_value, null: false
      t.integer :xp_bonus, default: 0
      t.string :rarity, default: "common"
      t.timestamps
    end

    create_table :user_achievements do |t|
      t.references :user, null: false, foreign_key: true
      t.references :achievement, null: false, foreign_key: true
      t.datetime :earned_at, null: false
      t.timestamps
    end

    add_index :user_achievements, [:user_id, :achievement_id], unique: true
  end
end
