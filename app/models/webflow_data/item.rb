module ::WebflowData
  def self.table_name_prefix
    'webflow_data_'
  end
  class Item < ApplicationRecord
    self.table_name = "webflow_data_items"
    store_accessor :webflow_data
    serialize :webflow_data, type: Hash#, coder: JSON
    self.inheritance_column = :collection_type
    belongs_to :webflow_data_collection, class_name: "WebflowData::Collection", optional: true, foreign_key: "collection_id"

    default_scope { order("position ASC") }
    scope :published, -> { where(_draft: false, _archived: false) }

    before_save :set_position

    def as_json(options = nil)
      self.webflow_data
    end

    def method_missing(method_name, *arguments, &block)

      # check for has_many relationships
      self.webflow_data_collection.fields.where(field_type: ["ItemRefSet", "ItemRef"]).each do |f|
        if f.slug.underscore == method_name.to_s
          # found it
          klass = f.referenced_collection.application_class
          # do we have any to look up?
          if item_ids = self.webflow_data[method_name.to_s] || []
            # return objects of the correct class name for the application
            return klass.where(webflow_id: item_ids).order_by_webflow_ids(item_ids)
            # return klass.where(webflow_id: item_ids).sort_by do |x|
            #   item_ids.index(x.webflow_id)
            # end
          end
        end
      end

      super

    end

    private

      def set_position
        self.position = self.webflow_data["position"] if self.webflow_data["position"]
      end

      def self.order_by_webflow_ids(ids)
        if ids.blank?
          order(nil)
        else
          order_by = ["CASE"]
          ids.each_with_index do |id, index|
            order_by << "WHEN webflow_id='#{id}' THEN #{index}"
          end
          order_by << "END"
          order(order_by.join(" "))
        end
      end

  end
end
