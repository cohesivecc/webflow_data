module WebflowData
  def self.table_name_prefix
    'webflow_data_'
  end
  class Field < ApplicationRecord
    self.table_name = "webflow_data_fields"
    belongs_to :webflow_data_collection, class_name: "WebflowData::Collection", optional: true, foreign_key: "webflow_data_collection_id"
  end
end
