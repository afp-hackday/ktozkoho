class CreateDatanestOtherDotations < ActiveRecord::Migration
  def self.up
    create_table :datanest_other_dotations do |t|
      t.string  :title, :limit => 10
      t.string  :name, :limit => 50
      t.string  :surname, :limit => 50
      t.string  :company, :limit => 200
      t.integer :ico
      t.string  :address, :limit => 200
      t.string  :mediator_company, :limit => 200
      t.float   :amount
      t.string  :currency, :limit => 5
      t.integer :year
      t.float   :requested_amount
      t.float   :utilized_amount
      t.string  :purpose, :limit => 500
      t.string  :note, :limit => 500
      t.string  :provider, :limit => 200
      t.string  :dotation_type, :limit => 100
      t.string  :project_number, :limit => 50
      t.string  :additional_note, :limit => 500
      t.date    :accepted_at
      t.date    :requested_at
    end
  end

  def self.down
    drop_table :datanest_other_dotations
  end
end
