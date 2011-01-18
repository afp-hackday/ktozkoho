#coding: utf-8
class Datanest::PartyLoan < Datanest::BaseInvestment
  csv           'pozicky_stranam-dump.csv'
  display_name  'Pôžičky stranám'

  def address
    "#{zip}, #{city}"
  end

  def self.label
    "Pôžička strane"
  end
end
