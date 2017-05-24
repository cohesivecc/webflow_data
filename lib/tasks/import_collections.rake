desc "Import the Collections from Webflow"
task import_collections: :environment do
  WebflowData::Collection.import
end
