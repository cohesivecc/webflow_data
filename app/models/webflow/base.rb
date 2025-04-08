module Webflow
  class Base

    attr_writer :_data

    def method_missing(method_name)
      str = method_name.id2name
      if webflow_data.has_key?(str)
        webflow_data[str]
      else
        raise NoMethodError
      end
    end

    def initialize(data)
      # underscore keys for Ruby-style attributes
      @_data = data.collect {|k, v| [k.underscore, v] }.to_h
    end

    def attributes
      webflow_data.keys
    end

    def webflow_data
      @_data
    end

    # Webflow defaults
    def id
      self.send('_id')
    end

    # Refresh the data via a call to Webflow
    def fetch!
      begin
        obj = self.class.find(self.id)
        @_data = obj.webflow_data
        true
      rescue
        false
      end
    end

    class << self


      def all(method, *args, **kwargs)
        client = WebflowData.client
        raise Exception.new("Client not configured correctly") and return unless client
        if resp = client.send(method, *args, **kwargs)
          if resp[0].is_a?(Hash) && resp[0]['err']
            raise Exception.new("Webflow API Error: #{resp['code']} - #{resp['err']}.")
          else
            resp.collect {|data| self.new(data) }
          end
        else
          []
        end
      end

      def find(method, *args, **kwargs)
        client = WebflowData.client
        raise Exception.new("Client not configured correctly") and return unless client
        if data = client.send(method, *args, **kwargs)
          self.new(data)
        else
          nil
        end
      end

    end

  end
end
