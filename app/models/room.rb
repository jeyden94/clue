# == Schema Information
#
# Table name: rooms
#
#  id         :bigint           not null, primary key
#  room_name  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Room < ApplicationRecord
end
