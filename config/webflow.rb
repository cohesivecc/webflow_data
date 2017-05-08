WEBFLOW_API_TOKEN = ENV[WEBFLOW_API_TOKEN]
WEBFLOW_SITE_ID   = ENV[WEBFLOW_SITE_ID]


# need to expose the raw HTTP methods to proxy requests
module Webflow
  class Client

    def proxy(path, method: :get, params: nil, data: nil)
      request(path, method: method, params: params, data: data)
    end

  end
end

files = Dir[Rails.root + 'app/models/*.rb']
models = files.map{ |m| File.basename(m, '.rb').camelize } #get models so we don't define one it if is already defined

collections = Webflow::Collection.all(WEBFLOW_SITE_ID)

collections.each do |c|
  Object.const_set(c.singular_name.delete(" "), Class.new(Item)) unless models.include?(c.singular_name.delete(" ")) # create model unless we have already defined it
end
