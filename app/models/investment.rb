class Investment < ActiveRecord::Base
  belongs_to :subject
  belongs_to :party
  belongs_to :investment, :polymorphic => true
end
