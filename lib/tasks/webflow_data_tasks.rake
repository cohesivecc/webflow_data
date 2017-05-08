
namespace :webflow_data do
  desc "copy initializer"
  task copy_initialzer: :environment do
    copy_file "../../config/initializers/webflow.rb", "config/initializers/webflow.rb"
  end
end
