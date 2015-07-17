class InstitutionMembership < ActiveRecord::Base
  belongs_to :institution
  belongs_to :memberable, :polymorphic => true
end
