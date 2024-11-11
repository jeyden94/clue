# == Schema Information
#
# Table name: suspects
#
#  id            :bigint           not null, primary key
#  suspect_color :string           not null
#  suspect_name  :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Suspect < ApplicationRecord
end
