#coding: utf-8
class Datanest::Eurofond < Datanest::Basis
  additional_currency_columns :budget

  csv                         'eurofondy-dump.csv'
  display_name                'Eurofondy'
end
