module ::WebflowData
  def self.table_name_prefix
    'webflow_data_'
  end
  class Item < ApplicationRecord
    self.table_name = "webflow_data_items"
    store_accessor :webflow_data
    serialize :webflow_data, Hash
    self.inheritance_column = :collection_type
    belongs_to :webflow_data_collection, class_name: "WebflowData::Collection", optional: true, foreign_key: "collection_id"

    default_scope { order("position ASC") }
    scope :published, -> { where(_draft: false, _archived: false) }

    before_save :set_position

    def as_json(options = nil)
      self.webflow_data
    end

    def method_missing(method_name, *arguments, &block)

      # is the method in our webflow_data structure?
      if item_ids = self.webflow_data[method_name.to_s]
        # check for has_many relationships
        self.webflow_data_collection.fields.where(field_type: ["ItemRefSet", "ItemRef"]).each do |f|
          if f.slug.underscore == method_name.to_s
            # found it
            klass = f.referenced_collection.application_class
            # return objects of the correct class name for the application
            return klass.where(webflow_id: item_ids)
          end
        end
      end

      super
      # has_many_slugs = self.webflow_data_collection.fields.where(field_type: ["ItemRefSet", "ItemRef"]).pluck(:slug)
      # matching_value = false
      # webflow_data_slug_lookup = ""
      #
      # has_many_slugs.each do |hms|
      #   if(hms.underscore.include?(method_name.to_s))
      #     matching_value = true
      #     webflow_data_slug_lookup = hms
      #   end
      # end
      #
      # if matching_value
      #
      #   c_id = Field.where(slug: webflow_data_slug_lookup.to_s).first.validations["collectionId"]
      #
      #   lookup_collection = Collection.where(webflow_id: c_id).first.singular_name.delete(" ").constantize
      #
      #   associated_ids = self.webflow_data[webflow_data_slug_lookup.underscore]
      #
      #   return lookup_collection.where(webflow_id: associated_ids)
      #
      # else
      #   super
      # end

    end

    private

      def set_position
        self.position = self.webflow_data["position"] if self.webflow_data["position"]
      end

  end
end
