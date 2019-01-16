module Webflow
  class Collection < Base

    def items(limit: 100)
      Webflow::Item.all(self.id, limit: limit)
    end

    def fields
      fetch! unless webflow_data['fields']
      webflow_data['fields'].collect {|data| Webflow::Field.new(data) }
    end

    class << self

      def all()
        super('collections', WebflowData.config.site_id)
      end

      def find(id)
        super('collection', id)
      end

    end

  end
end
