# == Schema Information
#
# Table name: weapons
#
#  id          :bigint           not null, primary key
#  weapon_name :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Weapon < ApplicationRecord
end