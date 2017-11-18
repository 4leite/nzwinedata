class DailySale < ApplicationRecord
  belongs_to :site

  default_scope { order(sale_date: :desc) }

  validates :customers, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :units, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :sale_date, uniqueness: { scope: :site }

  paginates_per 10

  monetize :sales_gross_cents

end
