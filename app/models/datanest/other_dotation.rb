#coding: utf-8
class Datanest::OtherDotation < Datanest::BaseAdvantage
  csv            'ine_dotacie-dump.csv'
  display_name   'Iné dotácie'

  def profit
    amount
  end
end
