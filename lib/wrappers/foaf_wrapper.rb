module Wrappers
  module FoafWrapper
    extend self

    def reload_all_connections
      Connection.delete_all
      Subject.find_each do |subject|
        print '.'
        subject.delay.load_connections
      end
    end
  end
end
