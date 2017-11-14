class Site < ApplicationRecord
  has_many :users
  has_many :daily_sales

  def to_s
    name
  end
end
