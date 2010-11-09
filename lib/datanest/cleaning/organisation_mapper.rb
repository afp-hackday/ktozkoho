module Datanest
  module Cleaning
    module OrganisationMapper
      def link_organisation
        if self[:company]
          best_match, strategy = try_exact_match, 'exact'
          best_match, strategy = try_fuzzy_historical_match, 'fuzzy_historical' if best_match.nil?
          best_match, strategy = try_fuzzy_match, 'fuzzy' if best_match.nil?

          if best_match
            link_best_match best_match, strategy
            puts "#{self[:company]}, #{self[:address]} --> #{best_match.name}, #{best_match.address} [by #{strategy}]"
          else
            puts "#{self[:company]}, #{self[:address]} --> No match.."
          end
        end
      end

      private

      def try_exact_match
        Datanest::Organisation
          .where('legal_form != ?', Datanest::Organisation::LEGAL_FORM_NOT_IN_ORSR)
          .where('lower(name) = ?', self[:company].downcase).first
      end

      def try_fuzzy_historical_match
        order_expression = "similarity('#{self[:company]}', name)"

        connection.execute "SELECT set_limit(0.5)"

        Datanest::Organisation.joins(:addresses)
          .where('legal_form != ?', Datanest::Organisation::LEGAL_FORM_NOT_IN_ORSR)
          .where('name % ?', self[:company])
          .where("#{pg_strip_address('datanest_organisation_addresses.address')} % #{pg_strip_address("?")}", self[:address])
          .where("similarity(#{pg_strip_address('datanest_organisation_addresses.address')}, #{pg_strip_address("?")}) > 0.9", self[:address])
          .order("#{order_expression} DESC").limit(1).first
      end

      def try_fuzzy_match
        order_expression = "similarity('#{self[:company]}', name)"

        connection.execute "SELECT set_limit(0.5)"

        Datanest::Organisation
          .where('legal_form != ?', Datanest::Organisation::LEGAL_FORM_NOT_IN_ORSR)
          .where('name % ?', self[:company])
          .where("#{pg_strip_address('address')} % #{pg_strip_address("?")}", self[:address])
          .where("similarity(#{pg_strip_address('address')}, #{pg_strip_address("?")}) > 0.9", self[:address])
          .order("#{order_expression} DESC").limit(1).first
      end

      def pg_strip_address address
        "regexp_replace(#{address}, E'[0-9, \\u00A0]', '', 'g')"
      end

      def link_best_match organisation, strategy
        self.subject = find_or_create_subject(organisation)
        self.mapping_strategy = strategy
      end

      def find_or_create_subject organisation
        Subject.find_or_create_by_datanest_organisation_id(:datanest_organisation_id => organisation.id,
                                                           :company => organisation.name,
                                                           :address => organisation.address,
                                                           :type => 'Company')
      end
    end
  end
end
