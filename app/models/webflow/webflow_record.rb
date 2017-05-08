module Webflow
  # Your models should inherit from this class
  class WebflowRecord < Item

    class << self

      def all(limit: 100)
        super(collection_id, limit: limit)
      end

      def find(id)
        super(collection_id, id)
      end

      #overwrite the collection_id for the specific webflow item you want
      def collection_id(_cid: nil)
        return _cid
      end

    end

  end
end
