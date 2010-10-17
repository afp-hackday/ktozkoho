class CreateDatanestPrivatizations < ActiveRecord::Migration
  def self.up
    create_table :datanest_privatizations do |t|
      t.string :privatized_comapny, :limit => 100
      t.string :privatized_company_address, :limit => 100
      t.float :estimate_amount
      t.integer :share
      t.string :company, :limit => 100
      t.string :name, :limit => 100
      t.string :surname, :limit => 100
      t.string :title, :limit => 10
      t.string :address, :limit => 100
      t.float :price_amount
      t.string :currency, :limit => 5
      t.date :sold_at
      t.string :privatization_form, :limit => 100
      t.string :seller, :limit => 100
      t.string :note, :limit => 500
    end
  end

  def self.down
    drop_table :datanest_privatizations
  end
end
