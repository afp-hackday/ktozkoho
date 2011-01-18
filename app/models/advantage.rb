class Advantage < ActiveRecord::Base
  belongs_to :subject
  belongs_to :advantage, :polymorphic => true
end