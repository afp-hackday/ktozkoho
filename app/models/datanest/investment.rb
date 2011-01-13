module Datanest
  class Investment < Datanest::Basis

    self.abstract_class = true

    def investment
      amount
    end
  end
end
