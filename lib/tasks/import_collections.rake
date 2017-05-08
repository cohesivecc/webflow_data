desc "Import the Collections from Webflow"
task import_collections: :environment do
  Collection.destroy_all
  @collections = Webflow::Collection.all(WEBFLOW_SITE_ID)

  @collections.each do |c|
    collection = Collection.new(
      name: c.name,
      webflow_data: c.webflow_data,
      singular_name: c.singular_name,
      slug: c.slug,
      webflow_id: c._id
    )
    c.fields.each do |f|
      collection.fields << Field.create(
        webflow_id: f.webflow_data["id"],
        field_type: f.webflow_data["type"],
        slug: f.webflow_data["slug"],
        name: f.webflow_data["name"],
        required: f.webflow_data["required"],
        validations: f.webflow_data["validations"]
      )
    end
    c.items.each do |i|
      collection.items << Item.create(
        name: i.name,
        webflow_id: i._id,
        webflow_collection_id: i._cid,
        _archived: i._archived,
        _draft: i._draft,
        slug: i.slug,
        webflow_data: i.webflow_data,
        collection_type: c.singular_name.delete(' ')
      )
    end
    collection.save
  end
end
