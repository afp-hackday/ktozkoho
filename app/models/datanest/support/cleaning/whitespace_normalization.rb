module Datanest
  module Support
    module Cleaning
      module WhitespaceNormalization
        def normalize_whitespace
          attribute_names.each do |attribute|
            if self[attribute] and self[attribute].respond_to? :gsub
              cleaned_attribute = self[attribute].gsub(/\302\240/u, " ");
              cleaned_attribute.squish
              self[attribute] = cleaned_attribute
            end
          end
        end
      end
    end
  end
end
