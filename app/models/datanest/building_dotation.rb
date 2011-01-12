#coding: utf-8
class Datanest::BuildingDotation < Datanest::Basis
  additional_currency_columns :project_value

  csv                         'dotacie_vystavba-dump.csv'
  display_name                'Stavebné dotácie'

  def address
    city || ''
  end

  def title
  end
end
