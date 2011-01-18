class Datanest::OrganisationHistoricalData < ActiveRecord::Base
  set_table_name :datanest_organisation_historical_data

  belongs_to :organisation

  scope :name_like, lambda { |name| where('LOWER(name) LIKE lower(?)', "#{name}%") }
  scope :ordered_name_and_address_similar_to, lambda { |name, address, similarity|
    where("name % ?", name)
    .where("strip_address(address) % strip_address(?)", address)
    .where("similarity(strip_address(address), strip_address(?)) > ?", address, similarity)
    .order("similarity(#{ActiveRecord::Base.quote_value(name)}, name) DESC")
  }
end
