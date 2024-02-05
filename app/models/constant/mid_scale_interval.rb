module Constant
  class MidScaleInterval < ApplicationRecord
    belongs_to :scale
    belongs_to :interval
    belongs_to :tonetype, class_name: 'ScaleTonetype'
  end
end
