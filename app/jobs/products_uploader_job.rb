# frozen_string_literal: true

require 'csv'

class ProductsUploaderJob < ApplicationJob
  queue_as :default

  DELIMITER = '¦'

  def perform(file_name)
    logger.info "Starting to perform file #{file_name}"

    CSV.foreach(file_name, col_sep: DELIMITER) do |row|
      Product.find_or_initialize_by(id: row[0]).tap do |product|
        product.supplier = Supplier.find_by(id: row[1])
        product.field1 = row[2]
        product.field2 = row[3]
        product.field3 = row[4]
        product.field4 = row[5]
        product.field5 = row[6]
        product.field6 = row[7]
        product.price = row[8]

        unless product.save
          logger.error "Product with id #{row[0]} wasn't saved"
        end
      end
    end

    logger.info "Finished. Deleting file #{file_name}"
    File.delete(file_name)
  end
end
