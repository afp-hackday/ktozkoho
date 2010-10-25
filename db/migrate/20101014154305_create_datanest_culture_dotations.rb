class CreateDatanestCultureDotations < ActiveRecord::Migration
  def self.up
    create_table :datanest_culture_dotations do |t|
      t.string :title, :limit => 40
      t.string :name, :limit => 100
      t.string :surname, :limit => 100
      t.string :company, :limit => 200
      t.string :ico, :limit => 20
      t.string :address, :limit => 200
      t.string :city, :limit => 100
      t.string :zip, :limit => 10
      t.string :district, :limit => 50
      t.string :county, :limit => 50
      t.float :dissaving
      t.string :currency, :limit => 5
      t.float :budget
      t.string :purpose, :limit => 500
      t.string :dotation_provider, :limit => 200
      t.integer :year
      t.string :note, :limit => 500
      t.string :additional_note, :limit => 500
      t.date   :contract_signed_at
    end
  end

  def self.down
    drop_table :datanest_culture_dotations
  end
end
