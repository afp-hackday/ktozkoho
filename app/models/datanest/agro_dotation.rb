#coding: utf-8
class Datanest::AgroDotation < Datanest::BaseAdvantage
  csv           'polnodotacie-dump.csv'
  display_name  'Agro dotácie'

  def profit
    dotation_amount
  end
end
