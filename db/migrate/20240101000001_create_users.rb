class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :xp, default: 0, null: false
      t.integer :level, default: 1, null: false
      t.integer :streak_days, default: 0, null: false
      t.date :last_activity_date
      t.string :theme, default: "dark"
      t.string :color_theme, default: "purple"
      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
