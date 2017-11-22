class DailySaleImport
  include ActiveModel::Model
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  validates :file, presence: true

  attr_accessor :file, :site_id

  SPREADSHEET_COLUMNS = { 
    sale_date: "Date",
    customers: "# Visitors",
    units: "# Bottles Sold",
    sales_gross: "$ Bottles Sold",
    notes: "Notes",
  }

  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  def save
    if !imported_daily_sales
      false
    elsif imported_daily_sales.map(&:valid?).all?
      imported_daily_sales.each(&:save!)
      true
    else
      imported_daily_sales.each_with_index do |daily_sale, index|
        daily_sale.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      false
    end
  end

  private

  def imported_daily_sales
    @imported_daily_sales ||= load_imported_daily_sales
  end

  def load_imported_daily_sales
    begin
      spreadsheet = Roo::Spreadsheet.open(file.path)
      header = spreadsheet.row(1)
    rescue => ex
      Rails.logger.error "File upload failed with errror: #{ex}"
      errors.add :base, "Spreadsheet import failed, please ensure you are uploading a valid file"
      return false
    end

    (2..spreadsheet.last_row).collect do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose] 

      daily_sale = DailySale.find_or_initialize_by(sale_date: row["Date"], site_id: ( site_id || row["Winery Id"] ))
      daily_sale.attributes = Hash[SPREADSHEET_COLUMNS.map{|k,v| [ k, row[v] ] } ]
      daily_sale
    end
  end

end
