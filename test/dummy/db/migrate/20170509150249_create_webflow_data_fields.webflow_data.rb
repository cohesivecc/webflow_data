# This migration comes from webflow_data (originally 20170505162650)
class CreateWebflowDataFields < ActiveRecord::Migration[5.0]
  def change
    enable_extension "hstore"
    create_table :webflow_data_fields do |t|
      t.string :webflow_id
      t.string :slug
      t.string :name
      t.boolean :required
      t.hstore :validations
      t.string :field_type
      t.integer :collection_id, index: true

      t.timestamps
    end
    add_foreign_key :webflow_data_fields, :webflow_data_collections, column: :collection_id
  end
end
