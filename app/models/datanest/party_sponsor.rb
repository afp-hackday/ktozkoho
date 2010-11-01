class Datanest::PartySponsor < ActiveRecord::Base
  extend Datanest::Import

  csv           'sponzori_stran-dump.csv'
  before_create :convert_financial_attributes, :correct_party_names, :empty_attributes_to_null

  scope :companies, where('company IS NOT NULL')
  scope :not_locked, where('locked_at IS NULL OR locked_at < ?', Time.now - 20.minutes)

  has_many :best_candidates, :class_name => 'Datanest::Organisation', :finder_sql =>
           'SELECT *
              FROM datanest_organisations
             WHERE name % \'#{company}\'
               AND address % \'#{address}\'
             ORDER BY similarity(name, \'#{company}\') DESC
             LIMIT 5'

  def self.find_and_lock_unmapped(limit = 5)
    limit = 5 if limit.nil?
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
