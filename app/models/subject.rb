class Subject < ActiveRecord::Base
  belongs_to :datanest_organisation
  has_one    :party_sponsor
  has_many   :connections
  has_many   :related_subjects, :through => :connections, :source => :connected_subject, :uniq => true

  def self.find_by_name_fuzzy(name)
    connection.execute "SELECT set_limit(0.9)"
    order_expression = "similarity(#{ActiveRecord::Base.quote_value(name)}, company) DESC"
    where('company % ?', name).order(order_expression).limit(1).first
  end
end
