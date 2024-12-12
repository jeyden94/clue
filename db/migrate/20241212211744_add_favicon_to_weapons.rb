class AddFaviconToWeapons < ActiveRecord::Migration[7.1]
  def change
    add_column :weapons, :favicon, :string
  end
end
