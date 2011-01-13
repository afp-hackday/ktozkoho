#coding: utf-8
class Datanest::PartyLoan < Datanest::Investment
  csv           'pozicky_stranam-dump.csv'
  display_name  'Pôžičky stranám'

  def address
    "#{zip}, #{city}"
  end
end
