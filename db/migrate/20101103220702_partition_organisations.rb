#coding: utf-8
class PartitionOrganisations < ActiveRecord::Migration
  def self.up
    execute "TRUNCATE datanest_organisations"
    remove_index :datanest_organisations, :name_trgm

    execute <<-SQL
      CREATE TABLE datanest_organisations_not_in_orsr (
        CHECK (legal_form = 'Podnikateľ-fyzická osoba-nezapísaný v obchodnom registri')
      ) INHERITS(datanest_organisations)
    SQL

    execute <<-SQL
      CREATE TABLE datanest_organisations_in_orsr (
        CHECK (legal_form != 'Podnikateľ-fyzická osoba-nezapísaný v obchodnom registri')
      ) INHERITS(datanest_organisations)
    SQL

    execute "CREATE LANGUAGE plpgsql"

    execute <<-SQL
      CREATE OR REPLACE FUNCTION organisations_insert_trigger()
      RETURNS TRIGGER AS $$
      BEGIN
          IF ( NEW.legal_form = 'Podnikateľ-fyzická osoba-nezapísaný v obchodnom registri') THEN
              INSERT INTO datanest_organisations_not_in_orsr VALUES (NEW.*);
          ELSE
              INSERT INTO datanest_organisations_in_orsr VALUES (NEW.*);
          END IF;
          RETURN NULL;
      END;
      $$
      LANGUAGE plpgsql;
    SQL

    execute <<-SQL
      CREATE TRIGGER insert_organisations_trigger
      BEFORE INSERT ON datanest_organisations
      FOR EACH ROW EXECUTE PROCEDURE organisations_insert_trigger();
    SQL

    execute <<-SQL
      CREATE INDEX index_datanest_organisations_in_orsr_on_name_gist_trgm
        ON datanest_organisations_in_orsr USING GIST(name gist_trgm_ops)
    SQL
  end

  def self.down
    drop_table :datanest_organisations_in_orsr
    drop_table :datanest_organisations_not_in_orsr
    execute <<-SQL
      DROP TRIGGER insert_organisations_trigger ON datanest_organisations
    SQL
  end
end
