class DatanestImport

  TABLE_PREFIX = 'datanest_'

  ActiveRecord::Base.establish_connection(YAML::load(File.open("#{Rails.root}/config/database.yml"))[Rails.env])

  def self.import_csvs
    Dir["#{Rails.root}/tmp/csv/*.csv"].each do |f|
      import_from_file f
    end
  end

  private

  def self.create_table! name, columns
    sql = "CREATE TABLE IF NOT EXISTS `#{name}` ("

    for column in columns.split(',')
      sql << "`#{column.strip}` VARCHAR(500),"
    end

    sql.gsub!(/,$/, '')
    sql << ')'

    ActiveRecord::Base.connection.execute(sql)
  end

  def self.import_data name, csv
    class_name = ActiveSupport::Inflector.classify(name)

    eval <<-EOF
      class ::#{class_name} < ActiveRecord::Base
        set_table_name '#{name}'
      end
    EOF

    class_name.constantize.fast_import(csv, :fields_terminated_by => ',' ,
                                            :fields_optionally_enclosed_by => '"',
                                            :ignore_lines => 1)

  end

  def self.drop_table! name
    sql = "DROP TABLE IF EXISTS `#{name}`"
    ActiveRecord::Base.connection.execute(sql)
  end

  def self.run_table_scripts name
    file_name = "#{Rails.root}/lib/datanest_scripts/#{name}.sql"

    if File.exists? file_name
      sql = ''
      File.open(file_name) { |f| sql = f.readlines.join }

      sql.split(';').each do |q|
        ActiveRecord::Base.connection.execute(q) unless q.strip.empty?
      end
    end
  end

  def self.import_from_file csv
    name = File.basename(csv)[0..-10]
    name = TABLE_PREFIX + name

    columns = ''

    File.open(csv, 'r') do |f|
      columns = f.readline
    end

    drop_table! name
    create_table! name, columns
    import_data name, csv
    run_table_scripts name
  end
end
