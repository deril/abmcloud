class CsvUploadsController < ApplicationController
  def new
    @uploader = UploaderFormObject.new
  end

  def create
    uploader = UploaderFormObject.new(file: params[:uploader_form_object][:file])
    uploader.save
  end
end
