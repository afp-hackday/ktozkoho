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

        private

        def link_organisation
          best_match, strategy = try_exact_match, 'exact'
          best_match, strategy = try_like_match(company), 'like'
          best_match, strategy = try_fuzzy_historical_match, 'fuzzy_historical' if best_match.nil?
          best_match, strategy = try_fuzzy_match, 'fuzzy' if best_match.nil?

          if best_match
            link_matched_subject(best_match, strategy)
            puts "#{company}, #{address} --> #{best_match.name}, #{best_match.address} [by #{strategy}]"
          else
            puts "#{company}, #{address} --> No match.."
          end
        end

        def try_exact_match
          Datanest::Organisation.in_orsr.where('lower(name) = ?', company.downcase).first
        end

        def try_like_match(name_part)
          matches = Datanest::Organisation.in_orsr.name_like(name_part)
          if matches.size == 1
            matches.first
          else
            index = name_part.rindex(/[^\w]/)
            if index
              try_like_match(name_part[0, index])
            else
              nil
            end
          end
        end

        def try_fuzzy_historical_match
          order_expression = "similarity(#{ActiveRecord::Base.quote_value(company)}, name) DESC"
          connection.execute "SELECT set_limit(0.5)"
          Datanest::Organisation.in_orsr.name_similar_to(company).historical_address_similar_to(address).order(order_expression).limit(1).first
        end

        def try_fuzzy_match
          order_expression = "similarity(#{ActiveRecord::Base.quote_value(company)}, name) DESC"
          connection.execute "SELECT set_limit(0.5)"
          Datanest::Organisation.in_orsr.name_similar_to(company).current_address_similar_to(address).order(order_expression).limit(1).first
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
          order_expression = "  similarity(#{ActiveRecord::Base.quote_value(name)}, name)
                              + similarity(#{ActiveRecord::Base.quote_value(surname)}, surname)
                              + similarity(#{ActiveRecord::Base.quote_value(address)}, address) DESC"

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
