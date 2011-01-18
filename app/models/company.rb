#encoding: utf-8
class Company < Subject
  PROBLEMATIC_PARTS = ['s.r.o.', 'a.s.', 'Bratislava'].freeze

  def self.clean_name name
    PROBLEMATIC_PARTS.each { |p| name.gsub!(p, '') }
    name.gsub!('PD', 'Poľnohospodárske družstvo')
    name.gsub!('RD', 'Roľnícke družstvo')
    name
  end

  def self.find_or_create_by_organization organization
    find_or_create_by_datanest_organisation_id(
      :datanest_organisation_id => organization.id,
      :company => organization.name,
      :address => organization.address)
  end

  def load_connections
    FoafProxy.related_companies(company).each do |related|
      related_subject = Subject.find_or_create_by_name_fuzzy(related)
      connections.create(:connected_subject => related_subject)
    end
  end

  def label
    company
  end
end
