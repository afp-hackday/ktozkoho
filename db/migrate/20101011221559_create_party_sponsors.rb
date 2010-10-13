class CreatePartySponsors < ActiveRecord::Migration
  def self.up
    create_table :datanest_party_sponsors, :options => 'ENGINE InnoDB COLLATE utf8_unicode_ci' do |t|
      t.string  :name, :limit => 100
      t.string  :surname, :limit => 100
      t.string  :title, :limit => 10
      t.string  :company, :limit => 100
      t.integer :ico
      t.float   :amount
      t.string  :currency, :limit => 3
      t.string  :address, :limit => 500
      t.string  :party, :limit => 20
      t.integer :year
    end

    add_index :datanest_party_sponsors, :ico
  end

  def self.down
    drop_table :datanest_party_sponsors
  end
end
