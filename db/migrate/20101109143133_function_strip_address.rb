class FunctionStripAddress < ActiveRecord::Migration
  def self.up
    sql = <<-SQL
      CREATE FUNCTION strip_address(address CHARACTER VARYING) RETURNS CHARACTER VARYING
      AS $$ SELECT regexp_replace($1, E'[0-9, \\u00A0]', '', 'g') $$
      LANGUAGE SQL
      IMMUTABLE
      RETURNS NULL ON NULL INPUT
    SQL

    execute sql
  end

  def self.down
    sql = <<-SQL
      DROP FUNCTION strip_address(CHARACTER VARYING)
    SQL

    execute sql
  end
end
