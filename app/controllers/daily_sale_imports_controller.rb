class DailySaleImportsController < ApplicationController

  def new
    @daily_sale_import = DailySaleImport.new
    puts @daily_sale_import.class
  end

  def create
    @daily_sale_import = DailySaleImport.new(params[:daily_sale_import])
    if @daily_sale_import.save
      redirect_to daily_sales_path, notice: "Imported sales data succesfully."
    else
      render :new
    end
  end

end
