# encoding: utf-8
module Datanest
  module Support
    module Matching
      def exact_match(try_name = company)
        Datanest::OrganisationHistoricalData.where('lower(name) = lower(?)', try_name).first.try(:organisation)
      end

      def ico_match
        Datanest::Organisation.where('ico = ?', ico).first if respond_to? :ico and ico
      end

      def like_match(name_part = company)
        matches = Datanest::OrganisationHistoricalData.name_like(name_part)
        if matches.size == 1
          matches.first.organisation
        else
          index = name_part.rindex(/[^\w]/)
          if index
            like_match(name_part[0, index])
          else
            nil
          end
        end
      end

      def fuzzy_match(try_name = company)
        with_trigram_similarity(0.8) do
          minimal_address_similarity = 0.9
          Datanest::OrganisationHistoricalData.ordered_name_and_address_similar_to(try_name, address, minimal_address_similarity).limit(1).first
        end
      end

      def find_best_match
        best_match, strategy = ico_match, 'ico'
        best_match, strategy = exact_match, 'exact' if best_match.nil?
        best_match, strategy = like_match, 'like' if best_match.nil?
        best_match, strategy = fuzzy_match, 'fuzzy' if best_match.nil?

        if best_match.nil? and (company.include? 'PD' or company.include? 'RD')
          replaced_name = company.gsub('PD', 'Poľnohospodárske družstvo').gsub('RD', 'Roľnícke družstvo')
          best_match, strategy = exact_match(replaced_name), 'exact w/ substs' if best_match.nil?
          best_match, strategy = like_match(replaced_name), 'like w/ substs' if best_match.nil?
          best_match, strategy = fuzzy_match(replaced_name), 'fuzzy w/substs' if best_match.nil?
        end

        [best_match, best_match ? strategy : nil]
      end
    end
  end
end
