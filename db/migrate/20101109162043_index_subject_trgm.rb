class IndexSubjectTrgm < ActiveRecord::Migration
  def self.up
    sql =<<-SQL
      CREATE INDEX index_subjects_on_name_surname_address_gist_trgm
        ON subjects USING GIST(name gist_trgm_ops, surname gist_trgm_ops, strip_address(address) gist_trgm_ops)
    SQL
    execute sql

    add_index :subjects, :datanest_organisation_id
  end

  def self.down
    execute "DROP INDEX index_subjects_on_name_surname_address_gist_trgm"
    remove_index :subjects, :datanest_organisation_id
  end
end
