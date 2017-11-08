class CreateSites < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.string :name

      t.timestamps
    end
    add_index :sites, :name, unique: true

    add_reference :users, :site, foreign_key: true
  end
end
