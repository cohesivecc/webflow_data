class AddPositionToWebflowDataItems < ActiveRecord::Migration[5.0]
  def change
    add_column :webflow_data_items, :position, :integer
  end
end
