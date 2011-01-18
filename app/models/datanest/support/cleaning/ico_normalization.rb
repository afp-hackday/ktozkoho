module Datanest
  module Support
    module Cleaning
      module ICONormalization

        def normalize_ico
          if respond_to? :ico and ico
            ico.gsub!(' ', '')
          end
        end

      end
    end
  end
end
