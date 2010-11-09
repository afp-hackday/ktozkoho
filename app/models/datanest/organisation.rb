#coding: utf-8
class Datanest::Organisation < ActiveRecord::Base
  extend Datanest::FastCSVImport

  LEGAL_FORM_NOT_IN_ORSR = 'Podnikateľ-fyzická osoba-nezapísaný v obchodnom registri'

  csv         'organisations-dump.csv'

  has_many :addresses, :class_name => 'Datanest::OrganisationAddress'
  has_many :name_histories, :class_name => 'Datanest::OrganisationNameHistory'
  has_one  :subject
end
