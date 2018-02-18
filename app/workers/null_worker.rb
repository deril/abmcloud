class NullWorker
  include Sidekiq::Worker

  def perform(*args)
    log.error 'Cannot determine worker to perform'
    # Do nothing
  end
end
