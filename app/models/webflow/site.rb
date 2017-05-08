module Webflow
  # https://developers.webflow.com/?shell#sites
  class Site < Base

    def domains
      Webflow::Domain.all(self.id)
    end

    def collections
      Webflow::Collection.all(self.id)
    end

    class << self

      def all
        super('sites')
      end

      def find(id)
        super('site', id)
      end

    end

  end
end
