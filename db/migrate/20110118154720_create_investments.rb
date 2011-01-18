class CreateInvestments < ActiveRecord::Migration
  def self.up
    create_table :investments do |t|
      t.float :amount
      t.integer :year
      t.references :subject
      t.string :investment_type
      t.references :investment
      t.references :party
    end
    add_index :investments, :subject_id
    add_index :investments, :party_id
  end

  def self.down
    drop_table :investments
  end
end
