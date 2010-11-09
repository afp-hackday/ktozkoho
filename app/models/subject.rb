class Subject < ActiveRecord::Base
  belongs_to :datanest_organisation
  has_one    :party_sponsor
end
