#coding: utf-8
module Datanest
  module Support
    module ManuallyMappable
      extend ActiveSupport::Concern

      included do
        scope :not_locked, where('locked_at IS NULL OR locked_at < ?', Time.now - 20.minutes)
        scope :manual_mapping_not_tried, where('mapping_strategy IS NULL OR mapping_strategy != ?', 'impossible')
        scope :not_yet_mapped, where('subject_id IS NULL')
        scope :mappable, not_yet_mapped.manual_mapping_not_tried.not_locked.where('company IS NOT NULL')

        has_many :best_candidates, :class_name => 'Datanest::Organisation', :finder_sql =>
                'SELECT o.*, similarity(o.name, \'#{Company.clean_name(company)}\')
                   FROM datanest_organisations o
                  WHERE o.name % \'#{company}\'
                    AND o.legal_form != \'' + Datanest::Organisation::LEGAL_FORM_NOT_IN_ORSR + '\'
                  ORDER BY similarity DESC
                  LIMIT 5'

        def as_json(options={})
          super(:only => [:id, :company, :address, :name], :include => { :best_candidates => { :include => :addresses  } } )
        end
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
              find_all_by_company_and_address(r.company, r.address).each do |l|
                l.locked_at = Time.now
                l.save
              end
            end
          end

          unlocked.reject { |ps| ps.best_candidates.first.nil? }.uniq
        end

        def percent_of_mapped
          1 - mappable.count.to_f / count.to_f
        end
      end
    end
  end
end
