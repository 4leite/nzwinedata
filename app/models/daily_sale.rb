class DailySale < ApplicationRecord
  include SpreadsheetArchitect

  belongs_to :site, inverse_of: :daily_sales

  default_scope { order(sale_date: :desc) }

  validates :customers, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :units, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :sale_date, uniqueness: { scope: :site }

  paginates_per 20

  SPREADSHEET_COLUMNS = [ 
    ['Date', :sale_date],
    ['# Visitors', :customers],
    ['# Bottles Sold', :units],
    ['$ Bottles Sold', :sales_gross],
    ['Notes', :notes],
  ]

  ADMIN_SPREADSHEET_COLUMNS = [['Winery Id', :site_id]] + SPREADSHEET_COLUMNS

  monetize :sales_gross_cents

  def spreadsheet_columns
    SPREADSHEET_COLUMNS
  end
end
