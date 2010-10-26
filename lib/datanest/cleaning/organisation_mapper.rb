module Datanest
  module Cleaning
    module OrganisationMapper
      def link_organisation
        unless self[:company].nil?

          best_match, strategy = try_exact_match, 'exact'
          best_match, strategy = try_fuzzy_match, 'fuzzy' if best_match.nil?

          unless best_match.nil?
            puts "#{self[:company]}, #{self[:address]} --> #{best_match.name}, #{best_match.address} [by #{strategy}]"
          else
            puts "#{self[:company]}, #{self[:address]} --> No match.."
          end
        end
      end

      private

      def try_exact_match
        Datanest::Organisation.where('lower(name) = ?', self[:company].downcase).first
      end

      def try_fuzzy_match
        order_expression = "similarity('#{self[:company]}', name)"

        Datanest::Organisation.where('name % ?', self[:company])
          .where('similarity(name, ?) > 0.5', self[:company])
          .where("#{pg_strip_address('address')} % #{pg_strip_address("?")}", self[:address])
          .where("similarity(#{pg_strip_address('address')}, #{pg_strip_address("?")}) > 0.9", self[:address])
          .order("#{order_expression} DESC").limit(1).first
      end

      def pg_strip_address address
        "regexp_replace(#{address}, E'[0-9, \\u00A0]', '', 'g')"
      end
    end
  end
end
