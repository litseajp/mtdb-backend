class Constant::MidAvailableChordGroupChord < ApplicationRecord
  belongs_to :available_chord_group
  belongs_to :chord
end
