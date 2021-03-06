class CreateWebflowDataItems < ActiveRecord::Migration[5.0]
  def change
    create_table :webflow_data_items do |t|
      t.boolean :_archived
      t.boolean :_draft
      t.string :webflow_id
      t.string :webflow_collection_id
      t.string :name
      t.string :slug
      t.date :updated_on
      t.date :created_on
      t.date :published_on
      t.date :updated_by
      t.date :created_by
      t.date :published_by
      t.string :collection_type
      t.jsonb :webflow_data
      t.integer :collection_id, index: true

      t.timestamps
    end
    add_foreign_key :webflow_data_items, :webflow_data_collections, column: :collection_id
    add_index :webflow_data_items, :webflow_data, using: :gin
  end
end
