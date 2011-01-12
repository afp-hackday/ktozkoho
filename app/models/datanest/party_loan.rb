#coding: utf-8
class Datanest::PartyLoan < Datanest::Basis
  before_create :correct_party_names

  csv           'pozicky_stranam-dump.csv'
  display_name  'Pôžičky stranám'

  def address
    "#{zip}, #{city}"
  end
end
