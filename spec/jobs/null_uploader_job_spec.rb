require 'rails_helper'

describe NullUploaderJob, type: :job do
  before { ActiveJob::Base.queue_adapter = :test }

  it 'schedules a job' do
    expect {
      NullUploaderJob.perform_later('test.csv')
    }.to have_enqueued_job
  end
end
