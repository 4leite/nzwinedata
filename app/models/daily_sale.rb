class DailySale < ApplicationRecord
  belongs_to :site

  default_scope { order(sale_date: :desc) }

  paginates_per 10

  monetize :sales_gross_cents
end
