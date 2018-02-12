Rails.application.routes.draw do
  resource :csv_upload, only: %i[new create]
end
