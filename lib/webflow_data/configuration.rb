module WebflowData

  class Configuration

    attr_accessor :api_token, :site_id

    def initialize
        @api_token = nil
        @site_id = nil
    end

  end

  def self.config
      @configuration ||= Configuration.new
  end

  def self.config=(config)
      @configuration = config
  end

  def self.configure
      yield config
  end

end
