class Story < ActiveRecord::Base
  belongs_to :user
  attr_accessible :subject, :subject_type, :user

  belongs_to :subject, :polymorphic => true
  belongs_to :list, :foreign_key => "item_id"
  belongs_to :list_item, :foreign_key => "item_id"
  belongs_to :comment, :foreign_key => "item_id"
end
