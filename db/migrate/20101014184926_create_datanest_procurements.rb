class CreateDatanestProcurements < ActiveRecord::Migration
  def self.up
    create_table :datanest_procurements do |t|
      t.integer :record_id
      t.integer :year
      t.integer :bulletin_id
      t.string :procurement_id, :limit => 100
      t.integer :customer_ico
      t.string :customer_company_name, :limit => 1000
      t.string :supplier_ico, :limit => 20
      t.string :supplier_company_name, :limit => 100
      t.string :supplier_region, :limit => 100
      t.text :procurement_subject
      t.float :price_amount
      t.string :currency, :limit => 50
      t.boolean :is_VAT_included
      t.text :customer_ico_evidence
      t.text :supplier_ico_evidence
      t.text :subject_evidence
      t.text :price_evidence
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
