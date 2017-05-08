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
      t.belongs_to :collection, foreign_key: true

      t.timestamps
    end
  end
end
