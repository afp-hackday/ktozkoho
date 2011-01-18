#coding: utf-8
class Datanest::CultureDotation < Datanest::BaseAdvantage
  additional_currency_columns :budget, :dissaving

  csv                         'dotacie_kultura-dump.csv'
  display_name                'Kultúrne dotácie'
  
  def profit
    dissaving
  end
end
