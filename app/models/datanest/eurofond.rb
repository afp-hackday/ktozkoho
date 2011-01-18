#coding: utf-8
class Datanest::Eurofond < Datanest::BaseAdvantage
  additional_currency_columns :budget

  csv                         'eurofondy-dump.csv'
  display_name                'Eurofondy'

  def profit
    grant_amount
  end
end
