# This migration comes from webflow_data (originally 20170524162534)
class AddPositionToWebflowDataItems < ActiveRecord::Migration[5.0]
  def change
    add_column :webflow_data_items, :position, :integer
  end
end
