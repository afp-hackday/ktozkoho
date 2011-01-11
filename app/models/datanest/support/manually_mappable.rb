#coding: utf-8
module Datanest
  module Support
    module ManuallyMappable
      extend ActiveSupport::Concern

      included do
        scope :not_locked, where('locked_at IS NULL OR locked_at < ?', Time.now - 20.minutes)
        scope :manual_mapping_not_tried, where('mapping_strategy IS NULL OR mapping_strategy != ?', 'impossible')
        scope :mappable, manual_mapping_not_tried.not_locked.where('company IS NOT NULL AND subject_id IS NULL', 'impossible')

        has_many :best_candidates, :class_name => 'Datanest::Organisation', :finder_sql =>
                'SELECT o.*, similarity(o.name, \'#{Company.clean_name(company)}\')
                   FROM datanest_organisations o
                  WHERE o.name % \'#{company}\'
                    AND o.legal_form != \'' + Datanest::Organisation::LEGAL_FORM_NOT_IN_ORSR + '\'
                  ORDER BY similarity DESC
                  LIMIT 5'
      end

      module ClassMethods
        attr_reader :dname

        def display_name name
          @dname = name
        end

        def find_and_lock_unmapped(limit = 5)
          limit = 5 if limit.nil?
          unlocked = []

          transaction do
            unlocked = mappable.limit(limit)
            unlocked.each do |r|
              r.locked_at = Time.now
              r.save
            end
          end

          #return [] if unlocked.size == 0

          unlocked.reject { |ps| ps.best_candidates.first.nil? }
          #unlocked.reject! { |ps| ps.best_candidates.first.nil? }
          #unlocked = unlocked + find_and_lock_unmapped(limit - unlocked.size) unless unlocked.size == limit
        end

        def percent_of_mapped
          1 - mappable.count.to_f / count.to_f
        end
      end
    end
  end
end
