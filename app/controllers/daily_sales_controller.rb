class DailySalesController < ApplicationController

  before_action :new_daily_sale, only: [:new]
  before_action :set_daily_sale, only: [:show, :edit, :update, :destroy]
  before_action :set_daily_sales, only: [:index, :new, :create, :update, :edit, :search]
  before_action :paginate_daily_sales, only: [:index, :new, :create, :update, :edit]
  before_action :set_sites, only: [:index, :new, :edit]

  helper_method :sort_column, :sort_order, :page

  # GET /daily_sales
  # GET /daily_sales.json
  def index
    respond_to do |format|
      format.html
      format.json
    end
  end

  def search
    respond_to do |format|
      format.html { 
        paginate_daily_sales
        render :index
      }
      format.xlsx { render xlsx: @daily_sales.to_xlsx(current_spreadsheet_options), filename: current_filename }
      format.ods { render ods: @daily_sales.to_ods(current_spreadsheet_options), filename: current_filename }
      format.csv { render csv: @daily_sales.to_csv(current_spreadsheet_options), filename: current_filename }
      format.json
    end
  end

  # GET /daily_sales/1
  # GET /daily_sales/1.json
  def show
  end

  # GET /daily_sales/new
  def new
  end

  # GET /daily_sales/1/edit
  def edit
  end

  # POST /daily_sales
  # POST /daily_sales.json
  def create
    @daily_sale = DailySale.new(daily_sale_params)

    respond_to do |format|
      if @daily_sale.save
        format.html { redirect_to new_daily_sale_path(page: page), notice: 'Daily Sale was successfully created.' }
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
        format.html { redirect_to daily_sales_path(page: page), notice: 'Daily Sale was successfully updated.' }
        format.json { render :show, status: :updated, location: @daily_sale }
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

  def current_spreadsheet_options
    if current_user.has_role? :global_admin
      { spreadsheet_columns: DailySale::ADMIN_SPREADSHEET_COLUMNS }
    else
      { spreadsheet_columns: DailySale::SPREADSHEET_COLUMNS }
    end
  end

  def current_filename
    if current_user.has_role? :global_admin
      "sales_data_all_#{Date.today}"
    else
      "sales_data_#{current_user.site}_#{Date.today}"
    end
  end

  def sort_column
    params[:sort].to_sym if DailySale.column_names.include?(params[:sort]) 
  end

  def sort_order
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def paginate_daily_sales
    @daily_sales = @daily_sales.page(page)
  end

  def page
    params[:page].to_i if params[:page]
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_daily_sales
    if current_user.has_role? :global_admin
      if params[:site_id]
        @daily_sales = Site.find(params[:site_id]).daily_sales
      else
        @daily_sales = DailySale.all
      end
    else
      @daily_sales = current_user.site.daily_sales
    end

    @daily_sales = @daily_sales.reorder(sort_column => sort_order) if sort_column
  end

  def set_daily_sale
    @daily_sale = DailySale.find(params[:id])
  end

  def new_daily_sale  
    @daily_sale = DailySale.new(sale_date: Date.current, site_id: current_user.site_id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def daily_sale_params
    params.require(:daily_sale).permit(:site_id, :sale_date, :customers, :units, :sales_gross, :notes, :page, :sort, :direction )
  end

  def set_sites 
    @sites = Site.all if current_user.has_role? :global_admin
  end
end
