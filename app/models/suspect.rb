# == Schema Information
#
# Table name: courses
#
#  id            :integer          not null, primary key
#  suspect_name  :string
#  suspect_color :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Suspect < ApplicationRecord
end
