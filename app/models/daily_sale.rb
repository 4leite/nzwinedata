class DailySale < ApplicationRecord
  include SpreadsheetArchitect

  belongs_to :site

  default_scope { order(sale_date: :desc) }

  validates :customers, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :units, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :sale_date, uniqueness: { scope: :site }

  paginates_per 20

  monetize :sales_gross_cents

  def self.to_csv_old
	 CSV.generate do |csv|
		csv << ['Date','# Customers','# Bottles Sold','$ Bottles Sold','Notes']
		all.each do |ds|
		  csv << [
			 I18n.l(ds.sale_date),
			 ds.customers,
			 ds.units,
			 ds.sales_gross,
			 ds.notes,
		  ]
		end
	 end
  end
end
