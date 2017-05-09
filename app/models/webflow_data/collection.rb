module WebflowData
  def self.table_name_prefix
    'webflow_data_'
  end
  class Collection < ApplicationRecord
    self.table_name = "webflow_data_collections"
    store_accessor :webflow_data
    serialize :webflow_data, Hash

    has_many :items, dependent: :destroy, class_name: "WebflowData::Item"
    has_many :fields, dependent: :destroy, class_name: "WebflowData::Field"
  end
end
