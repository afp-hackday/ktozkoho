module Datanest
  module Support
    module Cleaning
      module SubjectMapper
        def link_subject
          if company
            link_organisation
          elsif respond_to? :surname and surname
            link_physical_person
          end
        end

        private

        def link_organisation
          best_match, strategy = find_best_match

          if best_match
            link_matched_subject(best_match, strategy)
            puts "#{company}, #{address} --> #{best_match.name}, #{best_match.address} [by #{strategy}]"
          else
            puts "#{company}, #{address} --> No match.."
          end
        end

        def link_physical_person
          person = try_person_fuzzy_match

          if person
            self.mapping_strategy = 'fuzzy'
            puts "#{title} #{name} #{surname}, #{address} --> #{person.title} #{person.name} #{person.surname}, #{person.address} [by fuzzy]"
          else
            self.mapping_strategy = 'create_new'
            puts "#{title} #{name} #{surname}, #{address} --> No match [by create_new]"

            person = Person.new(:name => name, :surname => surname,
                                :title => title, :address => address)
            person.save
          end

          self.subject = person
        end

        def try_person_fuzzy_match
          order_expression = []
          order_expression << "similarity(#{ActiveRecord::Base.quote_value(name)}, name)" if name
          order_expression << "similarity(#{ActiveRecord::Base.quote_value(surname)}, surname)" if surname
          order_expression << "similarity(#{ActiveRecord::Base.quote_value(address)}, address)" if address

          where_expression = []
          where_expression << "name % #{ActiveRecord::Base.quote_value(name)}" if name
          where_expression << "surname % #{ActiveRecord::Base.quote_value(surname)}" if surname
          where_expression << "strip_address(address) % strip_address(#{ActiveRecord::Base.quote_value(address)})" if address

          with_trigram_similarity(0.8) do
            Person.where(where_expression.join(' AND ')).order(order_expression.join(' +  ') + " DESC").limit(1).first
          end
        end
      end
    end
  end
end
