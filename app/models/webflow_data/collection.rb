module WebflowData
  def self.table_name_prefix
    'webflow_data_'
  end
  class Collection < ApplicationRecord
    self.table_name = "webflow_data_collections"
    store_accessor :webflow_data
    serialize :webflow_data, type: Hash, coder: JSON

    has_many :items, dependent: :destroy, class_name: "WebflowData::Item"
    has_many :fields, dependent: :destroy, class_name: "WebflowData::Field"

    def application_class_name
      self.singular_name.gsub(/\s/, '')
    end
    def application_class
      self.application_class_name.constantize
    end

    def self.import
      self.destroy_all
      @collections = Webflow::Collection.all()

      @collections.each do |c|
        collection = self.new(
          name: c.name,
          webflow_data: c.webflow_data,
          singular_name: c.singular_name,
          slug: c.slug,
          webflow_id: c._id
        )
        c.fields.each do |f|
          collection.fields << WebflowData::Field.new(
            webflow_id: f.webflow_data["id"],
            field_type: f.webflow_data["type"],
            slug: f.webflow_data["slug"],
            name: f.webflow_data["name"],
            required: f.webflow_data["required"],
            validations: f.webflow_data["validations"]
          )
        end
        c.items(limit: 1000).each do |i|
          # puts i.inspect
          collection.items << WebflowData::Item.new(
            name: i.name,
            webflow_id: i._id,
            webflow_collection_id: i._cid,
            _archived: i._archived,
            _draft: i._draft,
            published_on: i.published_on,
            slug: i.slug,
            webflow_data: i.webflow_data,
            collection_type: c.singular_name.delete(' ')
          )
        end

        collection.save
      end
    end

  end
end
