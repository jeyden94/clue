class CreateRooms < ActiveRecord::Migration[7.1] # Replace 7.1 with your Rails version if different
  def change
    create_table :rooms do |t|
      t.string :room_name, null: false

      t.timestamps # Adds `created_at` and `updated_at` columns
    end
  end
end
