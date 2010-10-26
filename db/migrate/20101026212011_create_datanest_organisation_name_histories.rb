class CreateDatanestOrganisationNameHistories < ActiveRecord::Migration
  def self.up
    create_table :datanest_organisation_name_histories do |t|
      t.string :name, :limit => 1000
      t.references :organisation

      t.timestamps
    end
  end

  def self.down
    drop_table :datanest_organisation_name_histories
  end
end
