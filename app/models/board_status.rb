# == Schema Information
#
# Table name: board_statuses
#
#  id                  :bigint           not null, primary key
#  show_ballroom       :boolean          default(FALSE)
#  show_billiards_room :boolean          default(FALSE)
#  show_candle_stick   :boolean          default(FALSE)
#  show_conservatory   :boolean          default(FALSE)
#  show_dagger         :boolean          default(FALSE)
#  show_dining_room    :boolean          default(FALSE)
#  show_green          :boolean          default(FALSE)
#  show_hall           :boolean          default(FALSE)
#  show_kitchen        :boolean          default(FALSE)
#  show_lead_pipe      :boolean          default(FALSE)
#  show_library        :boolean          default(FALSE)
#  show_lounge         :boolean          default(FALSE)
#  show_mustard        :boolean          default(FALSE)
#  show_peacock        :boolean          default(FALSE)
#  show_plum           :boolean          default(FALSE)
#  show_revolver       :boolean          default(FALSE)
#  show_rope           :boolean          default(FALSE)
#  show_scarlett       :boolean          default(FALSE)
#  show_study          :boolean          default(FALSE)
#  show_white          :boolean          default(FALSE)
#  show_wrench         :boolean          default(FALSE)
#  x_coordinate        :integer
#  y_coordinate        :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  session_id          :integer          not null
#  turn_id             :integer
#
class BoardStatus < ApplicationRecord
  # Add any relationships, validations, or custom logic here if needed
end
