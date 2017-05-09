require "webflow_data/engine"
require "webflow_data/configuration"
module WebflowData
  # Your code goes here...
  def self.client
    @client ||= Webflow::Client.new(WebflowData.config.api_token) if WebflowData.config.api_token
  end
end
