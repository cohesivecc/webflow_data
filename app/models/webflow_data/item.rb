module WebflowData
  def self.table_name_prefix
    'webflow_data_'
  end
  class Item < ApplicationRecord
    self.table_name = "webflow_data_items"
    store_accessor :webflow_data
    serialize :webflow_data, Hash
    self.inheritance_column = :collection_type
    belongs_to :webflow_data_collection, class_name: "WebflowData::Collection", optional: true, foreign_key: "collection_id"

    def as_json(options = nil)
      self.webflow_data
    end

    def method_missing(method_name, *arguments, &block)
      has_many_slugs = self.collection.fields.where(field_type: ["ItemRefSet", "ItemRef"]).pluck(:slug)
      matching_value = false
      webflow_data_slug_lookup = ""
      has_many_slugs.each do |hms|
        if(hms.underscore.include?(method_name.to_s))
          matching_value = true
          webflow_data_slug_lookup = hms
        end
      end
      if matching_value
        associated_items = Field.where(slug: webflow_data_slug_lookup.to_s).first.validations["collectionId"]
        lookup_collection = Collection.where(webflow_id: associated_items).first.singular_name.delete(" ").constantize
        associated_ids = self.webflow_data[webflow_data_slug_lookup.underscore]
        return lookup_collection.where(webflow_id: associated_ids)
      else
        super
      end
    end

  end
end
