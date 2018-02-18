require 'rails_helper'

describe CsvUploadsController do
  describe 'GET new' do
    it 'assigns @uploader' do
      get :new
      expect(assigns(:uploader)).to be_a UploaderFormObject
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template 'new'
    end
  end

  describe 'POST create' do
    let(:file) { fixture_file_upload('assets/test.csv', 'text/csv') }

    it 'saves uploader' do
      uploader = instance_double UploaderFormObject
      expect(UploaderFormObject).to receive(:new) { uploader }
      expect(uploader).to receive(:save)
      post :create, params: { uploader_form_object: { file: file } }
    end

    it 'redirects to new' do
      post :create, params: { uploader_form_object: { file: file } }
      expect(response).to redirect_to(new_csv_upload_url)
      expect(flash[:notice]).to be_present
    end
  end
end