module WebflowData
  class Field < ApplicationRecord
    belongs_to :collection, class_name: 'WebflowData::Collection'
  end
end
