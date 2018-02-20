require 'rails_helper'

describe SuppliersUploaderJob, type: :job do
  before { ActiveJob::Base.queue_adapter = :test }
  describe 'schedule' do
    it 'schedules a job' do
      expect {
        SuppliersUploaderJob.perform_later('suppliers.csv')
      }.to have_enqueued_job
    end
  end

  describe '#perform' do
    subject { described_class.perform_now(File.join(fixture_path, 'suppliers.csv')) }

    before { allow(File).to receive(:delete) }

    it 'creates suppliers' do
      expect { subject }.to change{Supplier.count}.to(4)
    end
  end
end
