class CsvUploadsController < ApplicationController
  def new
    @uploader = UploaderFormObject.new
  end

  def create
    uploader = UploaderFormObject.new(file: params.dig(:uploader_form_object, :file))
    uploader.save
    flash[:notice] = 'File successfully uploaded'
    redirect_to new_csv_upload_url
  end
end
