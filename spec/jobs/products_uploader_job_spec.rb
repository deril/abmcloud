require 'rails_helper'

describe ProductsUploaderJob, type: :job do
  before { ActiveJob::Base.queue_adapter = :test }

  describe 'schedule' do
    it 'schedules a job' do
      expect {
        ProductsUploaderJob.perform_later('sku.csv')
      }.to have_enqueued_job
    end
  end

  describe '#perform' do
    subject { described_class.perform_now(File.join(fixture_path, 'sku.csv')) }

    before do
      allow(File).to receive(:delete)

      1.upto(4) do |i|
        create :supplier, id: "s000#{i}"
      end
    end

    it 'creates products' do
      expect { subject }.to change{Product.count}.to(4)
    end
  end
end
