module CSV
  module Cleaning
    module ICOMapper

      Hit = Struct.new(:cardinality, :query, :ico)

      EMPTY_QUERY = ''

      def ico_map_condition condition
        @ico_map_condition = condition
      end

      def map_icos
        @ico_map_condition ||= {:ico => nil}
        all(:conditions => @ico_map_condition).each do |record|

          organisation = Datanest::Organisation.find_by_name(record.company)
          unless organisation.nil?
            best_hit = Hit.new(1, '', organisation.ico)
          else
            best_hit = fulltext_search(record.company, :start_with => EMPTY_QUERY)

            if best_hit.cardinality > 1
              best_hit = fulltext_search(record.address, :start_with => best_hit.query)
            end
          end

          if best_hit.cardinality == 1
            record.ico = best_hit.ico
            record.save!
          end
        end
      end

      def fulltext_search q, options
        fulltext_query = options[:start_with]
        best_hit = Hit.new(999, '', '')

        q.split(' ').map(&:strip).each do |search_term|
          fulltext_query += " +#{search_term}"

          sql = <<-ESQL
            SELECT ico 
              FROM datanest_organisations 
            WHERE MATCH(name,address) AGAINST('#{fulltext_query}' IN BOOLEAN MODE )
          ESQL

          icos = Datanest::Organisation.find_by_sql(sql)

          if icos.size == 0
            to = " +#{search_term}".length + 1
            fulltext_query = fulltext_query[0..-to]
          else
            best_hit = Hit.new(icos.size, fulltext_query, icos[0].ico) if icos.size < best_hit.cardinality
          end

          break if icos.size == 1
        end unless q.nil?

        best_hit
      end
    end
  end
end
