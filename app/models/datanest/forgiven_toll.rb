#coding: utf-8
class Datanest::ForgivenToll < Datanest::Basis
  csv            'odpustene_clo-dump.csv'
  display_name   'Odpustené clo'

  def profit
    amount
  end
end
