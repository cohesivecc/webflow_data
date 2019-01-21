module WebflowData
  def self.table_name_prefix
    'webflow_data_'
  end
  class Field < ApplicationRecord
    self.table_name = "webflow_data_fields"
    belongs_to :webflow_data_collection, class_name: "WebflowData::Collection", optional: true, foreign_key: "collection_id"


    def reference_field?
      ["ItemRefSet", "ItemRef"].include?(self.field_type)
    end

    def referenced_collection
      self.reference_field? ? Collection.where(webflow_id: self.validations["collectionId"]) : nil
    end

  end
end
