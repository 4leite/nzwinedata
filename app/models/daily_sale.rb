class DailySale < ApplicationRecord
  belongs_to :site

  monetize :sales_gross_cents
end
