class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description
      t.string :difficulty, default: "easy", null: false
      t.string :category, default: "geral"
      t.boolean :completed, default: false, null: false
      t.datetime :completed_at
      t.date :due_date
      t.integer :xp_reward, null: false
      t.timestamps
    end

    add_index :tasks, [ :user_id, :completed ]
    add_index :tasks, [ :user_id, :created_at ]
  end
end
