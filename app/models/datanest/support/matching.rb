module Datanest
  module Support
    module Matching
      def exact_match
        Datanest::Organisation.in_orsr.where('lower(name) = ?', company.downcase).first
      end

      def ico_match
        Datanest::Organisation.in_orsr.where('ico = ?', ico).first if ico
      end

      def like_match(name_part = company)
        matches = Datanest::Organisation.in_orsr.name_like(name_part)
        if matches.size == 1
          matches.first
        else
          index = name_part.rindex(/[^\w]/)
          if index
            like_match(name_part[0, index])
          else
            nil
          end
        end
      end

      def fuzzy_match
        order_expression = "similarity(#{ActiveRecord::Base.quote_value(company)}, name) DESC"
        with_trigram_similarity(0.5) do
          Datanest::Organisation.in_orsr.current_or_historical_name_similar_to(company, 0.8).current_or_historical_address_similar_to(address, 0.9).order(order_expression).limit(1).first
        end
      end

      def find_best_match
        best_match, strategy = ico_match, 'ico'
        best_match, strategy = exact_match, 'exact' if best_match.nil?
        best_match, strategy = like_match(company), 'like' if best_match.nil?
        best_match, strategy = fuzzy_match, 'fuzzy' if best_match.nil?

        [best_match, best_match ? strategy : nil]
      end
    end
  end
end
