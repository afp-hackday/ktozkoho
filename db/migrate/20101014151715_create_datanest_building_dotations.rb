class CreateDatanestBuildingDotations < ActiveRecord::Migration
  def self.up
    create_table :datanest_building_dotations do |t|
      t.string :company, :limit => 100
      t.string :ico, :limit => 20
      t.string :name, :limit => 100
      t.string :surname, :limit => 100
      t.string :city, :limit => 50
      t.string :district, :limit => 100
      t.string :county, :limit => 100
      t.float :requested_amount
      t.float :assigned_amount
      t.float :project_value
      t.string :currency, :limit => 5
      t.string :purpose, :limit => 500
      t.string :dotation_type, :limit => 200
      t.string :note, :limit => 500
      t.integer :year
      t.string :dotation_provider, :limit => 200
      t.integer :apartment_count
      t.float :duct_dotation_amount
      t.float :sewage_dotation_amount
      t.float :electrical_dotation_amount
      t.float :road_dotation_amount
      t.float :gas_pipeline_dotation_amount
    end
  end

  def self.down
    drop_table :datanest_building_dotations
  end
end
