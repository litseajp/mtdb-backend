module Constant
  class ChordCategory < ApplicationRecord
    has_many :chords, dependent: :destroy
  end
end
