#coding: utf-8
class Datanest::CultureDotation < Datanest::Basis
  additional_currency_columns :budget, :dissaving

  csv                         'dotacie_kultura-dump.csv'
  display_name                'Kultúrne dotácie'
end
