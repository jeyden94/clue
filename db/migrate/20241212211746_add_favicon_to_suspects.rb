class AddFaviconToSuspects < ActiveRecord::Migration[7.1]
  def change
    add_column :suspects, :favicon, :string
  end
end
