class Story < ActiveRecord::Base
  belongs_to :user
  attr_accessible :subject, :subject_type, :user, :restaurant

  belongs_to :subject, :polymorphic => true

  belongs_to :list, :foreign_key => "subject_id"
  belongs_to :list_item, :foreign_key => "subject_id"
  belongs_to :comment, :foreign_key => "subject_id"
  belongs_to :relationship, :foreign_key => "subject_id"
  belongs_to :restaurant

  self.per_page = 10

  scope :includes_all, :include => {
    :user => [],
    :restaurant => [:city],
    :list_item => [:list],
    :list => [:user, :city],
    :relationship => [:follower, :followed],
    :comment => [],
  }
end
