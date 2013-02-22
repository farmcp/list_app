# == Schema Information
#
# Table name: stories
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  subject_type  :string(255)
#  subject_id    :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  restaurant_id :integer
#

class Story < ActiveRecord::Base
  belongs_to :user
  attr_accessible :subject, :subject_type, :user, :restaurant

  belongs_to :subject, :polymorphic => true

  belongs_to :list, :foreign_key => "subject_id"
  belongs_to :list_item, :foreign_key => "subject_id"
  belongs_to :comment, :foreign_key => "subject_id"
  belongs_to :relationship, :foreign_key => "subject_id"
  belongs_to :restaurant
  belongs_to :checkin, :foreign_key => "subject_id"

  self.per_page = 40

  scope :includes_all, :include => {
    :user => [],
    :restaurant => [:city],
    :list_item => [:list],
    :list => [:user, :city],
    :relationship => [:follower, :followed],
    :comment => [],
    :checkin => [:restaurant]
  }


  def item
    case subject_type
    when 'Comment'
      subject = comment
    when 'ListItem'
      subject = list_item
    when 'List'
      subject = list
    when 'Relationship'
      subject = relationship
    when 'Checkin'
      subject = checkin
    end
  end
end
