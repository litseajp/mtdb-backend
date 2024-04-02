module Constant
  class AvailableChordCategory < ApplicationRecord
    has_many :available_chord_groups, dependent: :destroy
  end
end
