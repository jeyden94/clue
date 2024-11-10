class AddWeaponNameToWeapons < ActiveRecord::Migration[7.1]
  def change
    add_column :weapons, :weapon_name, :string
  end
end
