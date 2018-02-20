require 'rails_helper'

describe UploaderFormObject do
  describe '#new' do
    let(:file) { fixture_file_upload('test.csv', 'text/csv') }

    subject { described_class.new(file: file) }

    its(:file) { is_expected.to eq file }
  end

  describe '#save' do
    let(:name_of_file) { 'test.csv' }
    let(:file) { fixture_file_upload(name_of_file, 'text/csv') }
    let(:filename) { "tmp/#{name_of_file}_#{@time_now.getutc.to_i}" }

    subject { described_class.new(file: file).save }

    before do
      @time_now = Time.now
      allow(Time).to receive(:now).and_return(@time_now)
    end

    it 'writes file' do
      filename = "tmp/test.csv_#{@time_now.getutc.to_i}"
      content = File.open(File.join(fixture_path, name_of_file), 'r').read
      expect(File).to receive(:binwrite).with(filename, content)
      subject
    end

    context 'when specific filename' do
      context 'when suppliers' do
        let(:name_of_file) { 'suppliers.csv' }

        it 'runs SuppliersUploaderJob' do
          expect(SuppliersUploaderJob).to receive(:perform_later).with(filename)
          subject
        end
      end

      context 'when sku' do
        let(:name_of_file) { 'sku.csv' }

        it 'runs ProductsUploaderJob' do
          expect(ProductsUploaderJob).to receive(:perform_later).with(filename)
          subject
        end
      end

      context 'when other' do
        it 'runs NullUploaderJob' do
          expect(NullUploaderJob).to receive(:perform_later).with(filename)
          subject
        end
      end
    end
  end
end
