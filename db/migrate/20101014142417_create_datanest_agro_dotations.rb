class CreateDatanestAgroDotations < ActiveRecord::Migration
  def self.up
    create_table :datanest_agro_dotations do |t|
      t.string :title, :limit => 20
      t.string :name, :limit => 100
      t.string :surname, :limit => 100
      t.string :company, :limit => 200
      t.string :ico, :limit => 20
      t.string :address, :limit => 500
      t.string :zip, :limit => 10
      t.string :city, :limit => 50
      t.string :region, :limit => 50
      t.float :requested_amount
      t.float :dotation_amount
      t.string :currency, :limit => 5
      t.integer :year
      t.string :purpose, :limit => 500
      t.string :income_number, :limit => 50
      t.string :note, :limit => 500
      t.string :paragraph, :limit => 50
      t.date   :commitee_meeting_at
      t.date   :requested_at
      t.date   :request_received_at
      t.string :document, :limit => 500
    end
  end

  def self.down
    drop_table :datanest_agrodotations
  end
end
