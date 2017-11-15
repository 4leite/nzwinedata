class CreateDailySales < ActiveRecord::Migration[5.1]
  def change
    create_table :daily_sales do |t|
      t.references :site, null:false, foreign_key: true
      t.date :sale_date, null: false
      t.integer :customers, null: false
      t.integer :units, null: false
      t.monetize :sales_gross, amount: { null: false, default: nil }
      t.text :notes

      t.timestamps
    end

    add_index :daily_sales, [:site_id, :sale_date], unique: true
  end
end
