class CreateDatanestConsolidations < ActiveRecord::Migration
  def self.up
    create_table :datanest_consolidations do |t|
      t.string :company, :limit => 200
      t.string :ico, :limit => 20
      t.string :title, :limit => 20
      t.string :name, :limit => 100
      t.string :surname, :limit => 100
      t.string :city, :limit => 50
      t.string :name2, :limit => 100
      t.float :amount
      t.string :currency, :limit => 5
      t.string :note, :limit => 500
      t.date   :updated_at
      t.string :legal_form, :limit => 50
      t.string :asset_number
      t.string :psc, :limit => 10
      t.string :surname2, :limit => 100
      t.string :name3, :limit => 100
      t.string :surname3, :limit => 100
    end
  end

  def self.down
    drop_table :datanest_consolidations
  end
end
