module Datanest
  module Support
    module FastCSVImport

      def csv name
        @csv_name = name
      end

      def load_csv_data
        delete_all

        csv = "#{Rails.root}/tmp/csv/#{@csv_name}"
        FileUtils.mkdir '/tmp/csv' unless File.exists? '/tmp/csv/'
        public_csv = "/tmp/csv/#{@csv_name}"
        FileUtils.cp csv, public_csv

        sql = <<-ESQL
          COPY #{quoted_table_name}
          FROM '#{public_csv}'
          CSV HEADER
        ESQL

        connection.execute sql
      end
    end
  end
end
