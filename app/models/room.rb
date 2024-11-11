# == Schema Information
#
# Table name: rooms
#
#  id            :integer          not null, primary key
#  room_name     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null

class Room < ApplicationRecord
end
