class DailySalesController < ApplicationController

  before_action :new_daily_sale, only: [:index, :new]
  before_action :set_daily_sale, only: [:show, :edit, :update, :destroy]
  before_action :set_daily_sales, only: [:index, :new, :create, :update, :edit]
  before_action :set_sites, only: [:index, :new, :edit]

  # GET /daily_sales
  # GET /daily_sales.json
  def index
  end

  # GET /daily_sales/1
  # GET /daily_sales/1.json
  def show
  end

  # GET /daily_sales/new
  def new
    render :index
  end

  # GET /daily_sales/1/edit
  def edit
    render :index
  end

  # POST /daily_sales
  # POST /daily_sales.json
  def create
    @daily_sale = DailySale.new(daily_sale_params)

    respond_to do |format|
      if @daily_sale.save
        format.html { redirect_to new_daily_sale_path(page: params[:page]), notice: 'Daily Sale was successfully created.' }
        format.json { render :show, status: :created, location: @daily_sale }
      else
        format.html { render :index }
        format.json { render json: @daily_sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_sales/1
  # PATCH/PUT /daily_sales/1.json
  def update
    respond_to do |format|
      if @daily_sale.update(daily_sale_params)
        format.html { redirect_to daily_sales_path(page: params[:page]), notice: 'Daily Sale was successfully updated.' }
        format.json { render :show, status: :updated, location: @daily_sale }
      else
        format.html { render :index }
        format.json { render json: @daily_sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /daily_sales/1
  # DELETE /daily_sales/1.json
  def destroy
    @daily_sale.destroy
    respond_to do |format|
      format.html { redirect_to daily_sales_url, notice: 'Daily sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_daily_sales
    if current_user.has_role? :global_admin
      if params[:site_id]
        @daily_sales = Site.find(params[:site_id]).daily_sales.page params[:page]
      else
        @daily_sales = DailySale.page params[:page]
      end
    else
      @daily_sales = current_user.site.daily_sales.page params[:page]
    end
  end

  def set_daily_sale
    @daily_sale = DailySale.find(params[:id])
  end

  def new_daily_sale  
    @daily_sale = DailySale.new(sale_date: Date.current, site_id: current_user.site_id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def daily_sale_params
    params.require(:daily_sale).permit(:site_id, :sale_date, :customers, :units, :sales_gross, :notes)
  end

  def set_sites 
    @sites = Site.all if current_user.has_role? :global_admin
  end
end
