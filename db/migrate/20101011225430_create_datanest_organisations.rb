class CreateDatanestOrganisations < ActiveRecord::Migration
  def self.up
    create_table :datanest_organisations do |t|
      t.string :name, :limit => 1000
      t.string :ico, :limit => 20
      t.string :address, :limit => 200
      t.string :legal_form, :limit => 200
      t.string :region, :limit => 100
      t.date   :started_at
      t.date   :ended_at
      t.text   :activity1
      t.text   :activity2
      t.string :account_sector, :limit => 200
      t.string :ownership, :limit => 100
      t.string :size, :limit => 100
      t.string :source_url, :limit => 4000
    end
  end

  def self.down
    drop_table :datanest_organisations
  end
end
