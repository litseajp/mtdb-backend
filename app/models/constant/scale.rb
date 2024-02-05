module Constant
  class Scale < ApplicationRecord
    belongs_to :scale_category

    has_many :mid_scale_intervals, dependent: :destroy
    has_many :intervals, through: :mid_scale_intervals
  end
end
