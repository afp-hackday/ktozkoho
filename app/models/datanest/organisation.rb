#coding: utf-8
class Datanest::Organisation < ActiveRecord::Base
  include Datanest::Base
  extend Datanest::Support::FastCSVImport

  LEGAL_FORM_NOT_IN_ORSR = 'Podnikateľ-fyzická osoba-nezapísaný v obchodnom registri'

  csv         'organisations-dump.csv'

  has_many :addresses, :class_name => 'Datanest::OrganisationAddress'
  has_many :name_histories, :class_name => 'Datanest::OrganisationNameHistory'
  has_one  :subject

  scope :in_orsr, where('legal_form != ?', Datanest::Organisation::LEGAL_FORM_NOT_IN_ORSR)
  scope :name_similar_to, lambda { |name| where('name % ?', name) }
  scope :name_like, lambda { |name| where("lower(name) like lower(?)", name + '%') }
  scope :historical_address_similar_to, lambda { |address|
    joins(:addresses)
    .where("strip_address(datanest_organisation_addresses.address) % strip_address(?)", address)
    .where("similarity(strip_address(datanest_organisation_addresses.address), strip_address(?)) > 0.9", address)
  }
  scope :current_address_similar_to, lambda { |address|
    where("strip_address(address) % strip_address(?)", address)
    .where("similarity(strip_address(address), strip_address(?)) > 0.9", address)
  }
end
