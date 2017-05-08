module WebflowData
  class Collection < ApplicationRecord
    store_accessor :webflow_data
    serialize :webflow_data, Hash

    has_many :items, dependent: :destroy
    has_many :fields, dependent: :destroy
  end
end
