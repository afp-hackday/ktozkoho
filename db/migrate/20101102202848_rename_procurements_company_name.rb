class RenameProcurementsCompanyName < ActiveRecord::Migration
  def self.up
    rename_column :datanest_procurements, :customer_company_name, :company
  end

  def self.down
    rename_column :datanest_procurements, :company, :customer_company_name
  end
end
