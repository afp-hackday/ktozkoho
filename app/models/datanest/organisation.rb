#coding: utf-8
class Datanest::Organisation < ActiveRecord::Base
  include Datanest::Support::Import

  LEGAL_FORM_NOT_IN_ORSR = 'Podnikateľ-fyzická osoba-nezapísaný v obchodnom registri'

  csv         'organisations-dump.csv'

  has_many :addresses, :class_name => 'Datanest::OrganisationAddress'
  has_many :name_histories, :class_name => 'Datanest::OrganisationNameHistory'
  has_one  :subject

  set_company_name_column :name

  before_create :abort_if_not_in_orsr, :normalize_company_name
  after_create  :split_name_and_address

  scope :in_orsr, lambda { where('legal_form != ?', Datanest::Organisation::LEGAL_FORM_NOT_IN_ORSR) }
  scope :name_similar_to, lambda { |name| where('name % ?', name) }
  scope :name_like, lambda { |name| where("lower(name) like ?", name.downcase + '%') }
  scope :current_or_historical_address_similar_to, lambda { |address, similarity|
    joins(:addresses)
    .where("strip_address(coalesce(datanest_organisation_addresses.address, datanest_organisations.address)) % strip_address(?)", address)
    .where("similarity(strip_address(datanest_organisation_addresses.address), strip_address(?)) > ?", address, similarity)
  }
  scope :current_or_historical_name_similar_to, lambda { |name, similarity|
    joins(:name_histories)
    .where("datanest_organisation_name_histories.name % ?", name)
    .where("similarity(coalesce(datanest_organisations.name, datanest_organisation_name_histories.name), ?) > ?", name, similarity)
  }
  scope :current_address_similar_to, lambda { |address, similarity|
    where("strip_address(address) % strip_address(?)", address)
    .where("similarity(strip_address(address), strip_address(?)) > ?", address, similarity)
  }

  def self.load_csv_data
    OrganisationNameHistory.delete_all
    OrganisationAddress.delete_all
    super
  end

  def in_orsr?
    legal_form != LEGAL_FORM_NOT_IN_ORSR
  end

  private
  def split_name_and_address
    if in_orsr?
      self.addresses.create(:address => address)
      self.name_histories.create(:name => name)
    end
  end

  def abort_if_not_in_orsr
    false unless in_orsr?
  end
end
