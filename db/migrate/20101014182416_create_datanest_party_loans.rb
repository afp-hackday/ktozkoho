class CreateDatanestPartyLoans < ActiveRecord::Migration
  def self.up
    create_table :datanest_party_loans do |t|
      t.string :title, :limit => 10
      t.string :name, :limit => 100
      t.string :surname, :limit => 100
      t.string :company, :limit => 200
      t.integer :ico
      t.string :zip, :limit => 10
      t.string :city, :limit => 100
      t.float :amount
      t.string :currency, :limit => 5
      t.string :party, :limit => 100
      t.integer :year
      t.date :received_at
      t.date :paid_at
      t.date :mature_at
      t.string :note, :limit => 500
    end
  end

  def self.down
    drop_table :datanest_party_loans
  end
end
