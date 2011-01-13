#coding: utf-8
class Datanest::PartySponsor < Datanest::Investment
  before_create :correct_party_names

  csv           'sponzori_stran-dump.csv'
  display_name  'Sponzori strán'
end
