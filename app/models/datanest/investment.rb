module Datanest
  class Investment < Datanest::Basis
    self.abstract_class = true

    belongs_to :party
    before_create :map_party

    def investment
      amount
    end
  end
end
