module CSVImportable
  def csv name
    @csv_name = name
  end

  def csv_columns columns
    @columns = columns
  end

  def load_csv_data
    csv = "#{Rails.root}/tmp/csv/#{@csv_name}"

    fast_import(csv, :fields_terminated_by => ',' ,
                     :fields_optionally_enclosed_by => '"',
                     :columns => @columns,
                     :ignore_lines => 1)
  end
end
