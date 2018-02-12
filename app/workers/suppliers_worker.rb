# -*- coding: utf-8 -*-
require 'csv'

class SuppliersWorker
  include Sidekiq::Worker
  DELIMITER = '¦'

  def perform(file_name)
    CSV.foreach(file_name, col_sep: DELIMITER) do |row|
      Supplier.find_or_initialize_by(id: row[0]).tap do |supplier|
        supplier.name = row[1]
        supplier.save
      end
    end
  end
end
