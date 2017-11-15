class Site < ApplicationRecord
  has_many :users
  has_many :daily_sales

  accepts_nested_attributes_for :users
  accepts_nested_attributes_for :daily_sales

  def to_s
    name
  end
end
