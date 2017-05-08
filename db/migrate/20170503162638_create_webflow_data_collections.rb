class CreateWebflowDataCollections < ActiveRecord::Migration[5.0]
  def change
    enable_extension "hstore"
    create_table :webflow_data_collections do |t|
      t.string :webflow_id
      t.jsonb :webflow_data
      t.date :last_updated
      t.date :created_on
      t.string :name
      t.string :slug
      t.string :singular_name

      t.timestamps
    end
    add_index :collections, :webflow_data, using: :gin
  end
end
