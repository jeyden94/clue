class AddFaviconToRooms < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :favicon, :string
  end
end
