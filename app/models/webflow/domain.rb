module Webflow
  class Domain < Base

    class << self

      def all(site_id)
        super('domains', site_id)
      end

      def find(*args)
        raise NoMethodError
      end

    end

  end
end
