module Constant
  class Chord < ApplicationRecord
    belongs_to :chord_category

    has_many :mid_chord_intervals, dependent: :destroy
    has_many :intervals, through: :mid_chord_intervals

    has_many :chord_positions, dependent: :destroy
  end
end
