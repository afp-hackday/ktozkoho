module Datanest
  module Cleaning
    module PhysicalPersonMapper

      def link_physical_person
        if name and surname and address
          subject = try_fuzzy_match

          if subject
            self.mapping_strategy = 'fuzzy'
            puts "#{title} #{name} #{surname}, #{address} --> #{subject.title} #{subject.name} #{subject.surname}, #{subject.address} [by fuzzy]"
          else
            self.mapping_strategy = 'create_new'
            puts "#{title} #{name} #{surname}, #{address} --> No match"

            subject = Subject.new(:name => name, :surname => surname,
                                  :title => title, :address => address,
                                  :type => 'PhysicalPerson')
            subject.save
          end

          self.subject = subject
        end
      end

      def try_fuzzy_match
        order_expression = "  similarity('#{name}', name)
                            + similarity('#{surname}', surname)
                            + similarity('#{address}', address) DESC"

        connection.execute "SELECT set_limit(0.8)"

        Subject
          .where('name % ?', name)
          .where('surname % ?', surname)
          .where("strip_address(address) % strip_address(?)", address)
          .order(order_expression).limit(1).first
      end
    end
  end
end
