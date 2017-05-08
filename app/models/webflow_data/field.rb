module WebflowData
  class Field < ApplicationRecord
    belongs_to :collection
  end
end
