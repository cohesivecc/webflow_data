class WebflowGenerator < Rails::Generators::Base
  def create_initializer_file
    create_file "config/initializers/webflow.rb",

%q{# Imported from webflow_data generator
WebflowData.configure do |config|
  config.api_token = "" # Enter your api credentials here
  config.site_id   = ""
end

files = Dir[Rails.root + 'app/models/*.rb']
models = files.map{ |m| File.basename(m, '.rb').camelize } #get models so we don't define one it if is already defined

collections = Webflow::Collection.all()

collections.each do |c|
  Object.const_set(c.singular_name.delete(" "), Class.new(WebflowData::Item)) unless models.include?(c.singular_name.delete(" ")) # create model unless we have already defined it
end}
  end
end
