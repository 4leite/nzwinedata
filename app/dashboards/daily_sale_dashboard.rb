require "administrate/base_dashboard"

class DailySaleDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    site: Field::BelongsTo,
    id: Field::Number,
    sale_date: Field::DateTime,
    customers: Field::Number,
    units: Field::Number,
    sales_gross_cents: Field::Number,
    sales_gross_currency: Field::String,
    notes: Field::Text,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :sale_date,
    :customers,
    :units,
    :sales_gross_cents,
    :site,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :sale_date,
    :site,
    :customers,
    :units,
    :sales_gross_cents,
    :sales_gross_currency,
    :notes,
    :created_at,
    :updated_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :site,
    :sale_date,
    :customers,
    :units,
    :sales_gross_cents,
    :sales_gross_currency,
    :notes,
  ].freeze

  # Overwrite this method to customize how daily sales are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(daily_sale)
  #   "DailySale ##{daily_sale.id}"
  # end

#  def valid_action?(name, resource = resource_class)
#    %w[edit].exclude?(name.to_s) && super
#  end
end
