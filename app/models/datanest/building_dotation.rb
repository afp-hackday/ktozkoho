#coding: utf-8
class Datanest::BuildingDotation < Datanest::BaseAdvantage
  additional_currency_columns :project_value

  csv                         'dotacie_vystavba-dump.csv'
  display_name                'Stavebné dotácie'

  def address
    city || ''
  end

  def title
  end

  def profit
    assigned_amount
  end
end
