class CreateDatanestProcurements < ActiveRecord::Migration
  def self.up
    create_table :datanest_procurements do |t|
      t.integer :record_id
      t.integer :year
      t.integer :bulletin_id
      t.integer :procurement_id
      t.integer :customer_ico
      t.string :customer_company_name, :limit => 100
      t.integer :supplier_ico
      t.string :supplier_company_name, :limit => 100
      t.string :supplier_region, :limit => 100
      t.string :procurement_subject, :limit => 200
      t.float :price_amount
      t.string :currency, :limit => 5
      t.boolean :is_VAT_included
      t.string :customer_ico_evidence, :limit => 100
      t.string :supplier_ico_evidence, :limit => 100
      t.string :subject_evidence, :limit => 100
      t.string :price_evidence, :limit => 100
      t.integer :procurement_type_id
      t.integer :document_id
      t.string :source_url, :limit => 1000
      t.string :batch_record_code, :limit => 200
    end
  end

  def self.down
    drop_table :datanest_procurements
  end
end
