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
        Datanest::Organisation.in_orsr.where('lower(name) = ?', company.downcase).first
      end

      def try_fuzzy_historical_match
        order_expression = "similarity('#{company}', name) DESC"
        connection.execute "SELECT set_limit(0.5)"
        Datanest::Organisation.in_orsr.name_similar_to(company).historical_address_similar_to(address).order(order_expression).limit(1).first
      end

      def try_fuzzy_match
        order_expression = "similarity('#{company}', name) DESC"
        connection.execute "SELECT set_limit(0.5)"
        Datanest::Organisation.in_orsr.name_similar_to(company).current_address_similar_to(address).order(order_expression).limit(1).first
      end

      def link_best_match organisation, strategy
        self.subject = find_or_create_subject(organisation)
        self.mapping_strategy = strategy
      end

      def find_or_create_subject organisation
        Subject.find_or_create_by_datanest_organisation_id(
             :datanest_organisation_id => organisation.id,
             :company => organisation.name,
             :address => organisation.address,
             :type => 'Company')
      end
    end
  end
end
