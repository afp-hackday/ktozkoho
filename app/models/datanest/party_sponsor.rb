#coding: utf-8
class Datanest::PartySponsor < Datanest::BaseInvestment
  csv           'sponzori_stran-dump.csv'
  display_name  'Sponzori strán'

  def self.label
    "Dar strane"
  end
end
