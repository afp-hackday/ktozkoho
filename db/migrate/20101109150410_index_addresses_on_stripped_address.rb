class IndexAddressesOnStrippedAddress < ActiveRecord::Migration
  def self.up
    sql = <<-SQL
      DROP INDEX index_datanest_organisation_addresses_on_address_gist_trgm
    SQL

    execute sql

    sql = <<-SQL
      CREATE INDEX index_datanest_organisation_addresses_on_address_gist_trgm
        ON datanest_organisation_addresses USING GIST(strip_address(address) gist_trgm_ops)
    SQL

    execute sql

    sql = <<-SQL
      CREATE INDEX index_datanest_organisations_in_orsr_on_address_gist_trgm
        ON datanest_organisations_in_orsr USING GIST(strip_address(address) gist_trgm_ops)
    SQL

    execute sql
  end

  def self.down
    sql = <<-SQL
      DROP INDEX index_datanest_organisation_addresses_on_address_gist_trgm
    SQL

    execute sql

    sql = <<-SQL
      CREATE INDEX index_datanest_organisation_addresses_on_address_gist_trgm
        ON datanest_organisation_addresses USING GIST(address gist_trgm_ops)
    SQL

    execute sql

    sql = <<-SQL
      DROP INDEX index_datanest_organisations_in_orsr_on_address_gist_trgm
    SQL

    execute sql
  end
end
