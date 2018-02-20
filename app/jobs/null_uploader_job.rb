class NullUploaderJob < ApplicationJob
  queue_as :default

  def perform(*args)
    log.error 'Cannot determine job to perform'
    # Do nothing
  end
end
