# frozen_string_literal: true

require 'csv'

class SuppliersUploaderJob < ApplicationJob
  queue_as :default

  DELIMITER = '¦'

  def perform(file_name)
    logger.info "Starting to perform file #{file_name}"

    CSV.foreach(file_name, col_sep: DELIMITER) do |row|
      Supplier.find_or_initialize_by(id: row[0]).tap do |supplier|
        supplier.name = row[1]

        unless supplier.save
          logger.error "Supplier with id #{row[0]} wasn't saved"
        end
      end
    end

    logger.info "Finished. Deleting file #{file_name}"
    File.delete(file_name)
  end
end
