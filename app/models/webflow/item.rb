module Webflow
  class Item < Base

    def collection
      @collection ||= Webflow::Collection.find(self.webflow_data['_cid'])
    end

    def fields
      collection.fields
    end

    def archived?
      self.send('_archived')
    end

    def draft?
      self.send('_draft')
    end

    def published?
      !draft? && !self.published_on.blank?
    end

    def save
      # create or update
    end

    class << self

      def all(collection_id, limit: 100)
        super('items', collection_id, limit: limit)
      end

      def find(collection_id, id)
        super('item', collection_id, id)
      end

    end

  end
end
