#coding: utf-8
class Datanest::Privatization < Datanest::BaseAdvantage
  csv            'privatizacia_predaje-dump.csv'
  display_name   'Privatizácie'

  def year
    sold_at.year
  end

  def profit
    price_amount
  end

end
