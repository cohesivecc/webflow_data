Rails.application.routes.draw do
  mount WebflowData::Engine => "/webflow_data"
end
