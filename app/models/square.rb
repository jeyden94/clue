# == Schema Information
#
# Table name: squares
#
#  id           :bigint           not null, primary key
#  location     :string
#  x_coordinate :integer
#  y_coordinate :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Square < ApplicationRecord
end
