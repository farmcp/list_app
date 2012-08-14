class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.references :user
      t.string :subject_type
      t.integer :subject_id

      t.timestamps
    end
    add_index :stories, :user_id
    add_index :stories, [:subject_type, :subject_id]
  end
end
