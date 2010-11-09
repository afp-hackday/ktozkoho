module Datanest
  module Cleaning
    module PhysicalPersonMapper

      def link_physical_person
        if name and surname and address
          subject = try_fuzzy_match

          if subject
            puts "#{self[:title]} #{self[:name]} #{self[:surname]}, #{self[:address]} --> #{subject.title} #{subject.name} #{subject.surname}, #{subject.address} [by fuzzy]"
          else
            puts "#{self[:title]} #{self[:name]} #{self[:surname]}, #{self[:address]} --> No match"

            subject = Subject.new(:name => self[:name], :surname => self[:surname],
                                  :title => self[:title], :address => self[:address],
                                  :type => 'PhysicalPerson')
            subject.save
          end

          self.subject = subject
          self.mapping_strategy = 'fuzzy'
        end
      end

      def try_fuzzy_match
        order_expression = "  similarity('#{self[:name]}', name)
                            + similarity('#{self[:surname]}', surname)
                            + similarity('#{self[:address]}', address)"

        connection.execute "SELECT set_limit(0.8)"

        Subject
          .where('name % ?', self[:name])
          .where('surname % ?', self[:surname])
          .where("#{pg_strip_address('address')} % #{pg_strip_address("?")}", self[:address])
          .order("#{order_expression} DESC").limit(1).first
      end

      def pg_strip_address address
        "regexp_replace(#{address}, E'[0-9, \\u00A0]', '', 'g')"
      end
    end
  end
end
