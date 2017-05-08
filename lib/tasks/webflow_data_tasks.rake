namespace :webflow_data do
  desc "copy initializer"
  task copy_initialzer: :environment do
    `bin/rails generate webflow`
  end
end
