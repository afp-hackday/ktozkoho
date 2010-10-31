class Datanest::PartySponsor < ActiveRecord::Base
  extend Datanest::Import

  csv           'sponzori_stran-dump.csv'
  before_create :convert_financial_attributes, :correct_party_names, :empty_attributes_to_null

  scope :companies, where('company IS NOT NULL')
  scope :not_locked, where('locked_at IS NULL OR locked_at < ?', Time.now - 20.minutes)

  def best_candidates
    Datanest::Organisation.where('name % ? AND address % ?', self[:company], self[:address])
                          .order("similarity(name, '#{company}') DESC")
                          .limit(5)
  end

  def self.find_and_lock_unmapped(limit = 10)
    unlocked = []

    transaction do
      unlocked = companies.not_locked.limit(limit)
      unlocked.each do |r|
        r.locked_at = Time.now
        r.save
      end
    end

    unlocked
  end

end
