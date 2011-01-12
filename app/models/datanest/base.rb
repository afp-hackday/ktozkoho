module Datanest::Base

  #before_update :update_same_company_records

  def update_same_company_records
    find_all_by_company_and_address(company, address).each do |record|
      record.update_attributes(:subject_id => subject_id, :mapping_strategy => mapping_strategy)
    end
  end

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
