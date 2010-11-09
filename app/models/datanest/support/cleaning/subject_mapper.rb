module Datanest
  module Support
    module Cleaning
      module SubjectMapper
        def link_subject
          if company
            link_organisation
          elsif respond_to? :surname and surname and address
            link_physical_person
          end
        end

        def link_organisation
          best_match, strategy = try_exact_match, 'exact'
          best_match, strategy = try_fuzzy_historical_match, 'fuzzy_historical' if best_match.nil?
          best_match, strategy = try_fuzzy_match, 'fuzzy' if best_match.nil?

          if best_match
            link_best_match best_match, strategy
            puts "#{company}, #{address} --> #{best_match.name}, #{best_match.address} [by #{strategy}]"
          else
            puts "#{company}, #{address} --> No match.."
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
          Company.find_or_create_by_datanest_organisation_id(
                :datanest_organisation_id => organisation.id,
                :company => organisation.name,
                :address => organisation.address)
        end

        def link_physical_person
          if name and surname and address
            person = try_person_fuzzy_match

            if person
              self.mapping_strategy = 'fuzzy'
              puts "#{title} #{name} #{surname}, #{address} --> #{person.title} #{person.name} #{person.surname}, #{person.address} [by fuzzy]"
            else
              self.mapping_strategy = 'create_new'
              puts "#{title} #{name} #{surname}, #{address} --> No match"

              person = Person.new(:name => name, :surname => surname,
                                  :title => title, :address => address)
              person.save
            end

            self.subject = person
          end
        end

        def try_person_fuzzy_match
          order_expression = "  similarity('#{name}', name)
                              + similarity('#{surname}', surname)
                              + similarity('#{address}', address) DESC"

          connection.execute "SELECT set_limit(0.8)"

          Person
            .where('name % ?', name)
            .where('surname % ?', surname)
            .where("strip_address(address) % strip_address(?)", address)
            .order(order_expression).limit(1).first
        end
      end
    end
  end
end
