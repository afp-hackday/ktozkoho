module CSV
  module Cleaning
    module ICONuller
      def null_icos
        update_all("ico = NULL", :ico => 0)
      end
    end
  end
end
