class CreateDatanestForgivenTolls < ActiveRecord::Migration
  def self.up
    create_table :datanest_forgiven_tolls do |t|
      t.string :company, :limit => 200
      t.string :title, :limit => 10
      t.string :name, :limit => 100
      t.string :surname, :limit => 100
      t.integer :ico
      t.string :address, :limit => 200
      t.string :zip, :limit => 10
      t.string :city, :limit => 100
      t.string :paragraph, :limit => 100
      t.float  :amount
      t.string :currency, :limit => 5
      t.integer :year
      t.string :toll_office, :limit => 100
      t.string :note, :limit => 500
      t.string :additional_note, :limit => 500
    end
  end

  def self.down
    drop_table :datanest_forgiven_tolls
  end
end
