class DailySalesController < ApplicationController
  before_action :set_daily_sale, only: [:show, :edit, :update, :destroy]
  before_action :set_daily_sales, only: [:index]
  before_action :set_sites, only: [:new, :edit]

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
    @daily_sale = DailySale.new
    @daily_sale.sale_date ||= Date.current
  end

  # GET /daily_sales/1/edit
  def edit
  end

  # POST /daily_sales
  # POST /daily_sales.json
  def create
    # @daily_sale = DailySale.new( daily_sale_params )
    
    daily_sale_params[:site_id] ||= current_user.site_id

    @daily_sale = DailySale.find_or_initialize_by(
      site_id: daily_sale_params[:site_id], 
      sale_date: daily_sale_params[:sale_date])

    @daily_sale.update_attributes(daily_sale_params)

    respond_to do |format|
      if @daily_sale.save
        format.html { redirect_to @daily_sale, notice: 'Daily sale was successfully created.' }
        format.json { render :show, status: :created, location: @daily_sale }
      else
        format.html { render :new }
        format.json { render json: @daily_sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /daily_sales/1
  # PATCH/PUT /daily_sales/1.json
  def update
    respond_to do |format|
      if @daily_sale.update(daily_sale_params)
        format.html { redirect_to @daily_sale, notice: 'Daily sale was successfully updated.' }
        format.json { render :show, status: :ok, location: @daily_sale }
      else
        format.html { render :edit }
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
      @daily_sales = DailySale.all
    else
      @daily_sales = current_user.site.daily_sales
    end
  end

  def set_daily_sale
    @daily_sale = DailySale.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def daily_sale_params
    params.require(:daily_sale).permit(:site_id, :sale_date, :customers, :units, :sales_gross, :notes)
  end
 
  def set_sites 
    @sites = Site.all if current_user.has_role? :global_admin
  end
end
