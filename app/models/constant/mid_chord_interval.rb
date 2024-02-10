module Constant
  class MidChordInterval < ApplicationRecord
    belongs_to :chord
    belongs_to :interval
  end
end
