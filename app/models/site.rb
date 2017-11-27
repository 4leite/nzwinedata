class Site < ApplicationRecord
  has_many :users, inverse_of: :site
  has_many :daily_sales, inverse_of: :site

  accepts_nested_attributes_for :users
  accepts_nested_attributes_for :daily_sales

  def to_s
    name
  end

  def users_count
    users.count
  end
end
