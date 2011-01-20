class Datanest::Basis < ActiveRecord::Base
  include Datanest::Support::Matching
  include Datanest::Support::Import
  include Datanest::Support::ManuallyMappable

  self.abstract_class = true

  belongs_to :subject

  before_save :empty_attributes_to_null, :normalize_whitespace, :convert_financial_attributes,
              :normalize_company_name, :normalize_ico, :link_subject

  def link_matched_subject organization, strategy
    self.subject = Company.find_or_create_by_organization(organization)
    self.mapping_strategy = strategy
  end

  def ==(other)
    company == other.company and address == other.address and name == other.name and surname == other.surname
  end

  def eql?(other)
    self == other
  end

  def hash
    company.hash + address.hash + name.hash + surname.hash
  end
end
