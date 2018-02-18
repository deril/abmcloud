# frozen_string_literal: true

class UploaderFormObject
  include ActiveModel::Model

  attr_accessor :file
  FILE_MASK = 'tmp/%<filename>s_%<timestamp>i'
  PERFORMERS = {
    'suppliers.csv' => SuppliersWorker,
    'sku.csv' => ProductsWorker
  }.freeze

  def save
    file_name = format(FILE_MASK, filename: file.original_filename, timestamp: Time.now.getutc.to_i)
    File.binwrite(file_name, file.read)
    PERFORMERS.fetch(file.original_filename, NullWorker).perform_async(file_name)
  end
end
