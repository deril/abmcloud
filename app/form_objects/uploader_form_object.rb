class UploaderFormObject
  include ActiveModel::Model

  attr_accessor :file

  def save
    File.binwrite('tmp/suppliers.csv', file.read)
    SuppliersWorker.perform_async('tmp/suppliers.csv')
  end
end
