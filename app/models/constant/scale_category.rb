module Constant
  class ScaleCategory < ApplicationRecord
    has_many :scales, dependent: :destroy
  end
end
