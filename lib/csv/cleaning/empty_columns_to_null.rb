module CSV
  module Cleaning
    module EmptyColumnsToNULL
      def empty_columns_to_null
        column_names.each do |column_name|
          update_all("#{column_name} = NULL", ["#{column_name} = ?", ''])
        end
      end
    end
  end
end
