module Datanest
  module Cleaning
    module EmptyAttributesToNull

      def empty_attributes_to_null
        attribute_names.each do |attribute|
          if not self[attribute].nil? and self[attribute].respond_to? :empty? and self[attribute].empty?
          self[attribute] = nil
          end
        end
      end

    end
  end
end
