class DailySaleImportsController < ApplicationController
  before_action :new_daily_sale_import, only: [:new, :create]

  def new
  end

  def create
    @daily_sale_import = DailySaleImport.new(daily_sale_import_attributes)

    if @daily_sale_import.save
      redirect_to daily_sales_path, notice: "Imported sales data succesfully."
    else
      render :new
    end
  end

  private

  def new_daily_sale_import
    @daily_sale_import = DailySaleImport.new
  end

  def daily_sale_import_attributes
    attributes = params[:daily_sale_import] || {}
    if current_user.has_role? :global_admin
      attributes.except :site_id 
    else
      attributes[:site_id] = current_user.site_id
      attributes
    end
  end
end
