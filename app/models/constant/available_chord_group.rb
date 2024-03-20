class Constant::AvailableChordGroup < ApplicationRecord
  belongs_to :available_chord_category
  belongs_to :degree

  has_many :mid_available_chord_group_chords, dependent: :destroy
  has_many :chords, through: :mid_available_chord_group_chords
end
