class Datanest::BaseAdvantage < Datanest::Basis
  self.abstract_class = true
  has_one :advantage, :as => :advantage
end
