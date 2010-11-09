class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.string :company, :limit => 500
      t.string :title, :limit => 50
      t.string :name, :limit => 100
      t.string :surname, :limit => 100
      t.string :address, :limit => 200
      t.string :type, :limit => 30
      t.references :datanest_organisation
      t.timestamps
    end
  end

  def self.down
    drop_table :subjects
  end
end
