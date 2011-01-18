class Subject < ActiveRecord::Base
  belongs_to :datanest_organisation

  has_many :advantages
  has_many :agro_dotations, :class_name => 'Datanest::AgroDotation'
  has_many :building_dotations, :class_name => 'Datanest::BuildingDotation'
  has_many :consolidations, :class_name => 'Datanest::Consolidation'
  has_many :culture_dotations, :class_name => 'Datanest::CultureDotation'
  has_many :eurofonds, :class_name => 'Datanest::Eurofond'
  has_many :forgiven_tolls, :class_name => 'Datanest::ForgivenToll'
  has_many :other_dotations, :class_name => 'Datanest::OtherDotation'
  has_many :party_loans, :class_name => 'Datanest::PartyLoan'
  has_many :party_sponsors, :class_name => 'Datanest::PartySponsor'
  has_many :privatizations, :class_name => 'Datanest::Privatization'
  has_many :procurements, :class_name => 'Datanest::Procurement'

  has_many   :connections
  has_many   :related_subjects, :through => :connections, :source => :connected_subject, :uniq => true

  def self.find_by_name_fuzzy(name)
    connection.execute "SELECT set_limit(0.9)"
    order_expression = "similarity(#{ActiveRecord::Base.quote_value(name)}, company) DESC"
    where('company % ?', name).order(order_expression).limit(1).first
  end

  def advantages
    agro_dotations + building_dotations + consolidations + culture_dotations + eurofonds + forgiven_tolls + other_dotations + privatizations + procurements
  end

  def investments
    party_loans + party_sponsors
  end

  def profits_per_year
    yearly_summary_of(advantages, :profit)
  end

  def investments_per_year
    yearly_summary_of(investments, :investment)
  end

  private
  def yearly_summary_of(subjects, of)
    summary = (1993..Time.now.year).to_a.inject({}){|hash, year| hash[year] = 0; hash}
    subjects.group_by(&:year).each do |year, subjects_array|
      summary.merge!(year => subjects_array.sum{ |s| s.send of}){|key, original_value, new_value| original_value + new_value }
    end
    summary
  end
end
