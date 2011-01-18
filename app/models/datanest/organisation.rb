#coding: utf-8
class Datanest::Organisation < ActiveRecord::Base
  include Datanest::Support::Import

  LEGAL_FORM_NOT_IN_ORSR = 'Podnikateľ-fyzická osoba-nezapísaný v obchodnom registri'

  csv         'organisations-dump.csv'

  has_many :historical_data, :class_name => 'Datanest::OrganisationHistoricalData'
  has_one  :subject

  set_company_name_column :name
  before_create :abort_if_not_in_orsr, :normalize_company_name
  after_create  :split_name_and_address

  def self.load_csv_data
    OrganisationHistoricalData.delete_all
    super
  end

  def in_orsr?
    legal_form != LEGAL_FORM_NOT_IN_ORSR
  end

  private
  def split_name_and_address
    if in_orsr?
      self.historical_data.create(:name => name, :address => address)
    end
  end

  def abort_if_not_in_orsr
    false unless in_orsr?
  end
end
