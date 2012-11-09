class EditRequest < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  attr_accessible :rejected, :approved, :params, :restaurant

  validates_presence_of :user_id, :restaurant_id, :params

  scope :needs_review, where(accepted: false, rejected: false)

  def parsed_params
    @parsed_params ||= JSON.load(params)
  end

  def status
    rejected? ? 'rejected' : accepted? ? 'accepted' : 'not reviewed'
  end

  def has_diff?
    return false if accepted?
    parsed_params.any? do |key, val|
      before = val.to_s
      after = restaurant.attributes[key].to_s
      before != after
    end
  end

  def diff(key, val)
    before = restaurant.attributes[key].to_s
    if before == val
      "<div><i>same</i></div>"
    else
      Differ.diff_by_line(val, before).format_as(:html)
    end
  end

  def accept!
    parsed_params.each do |key, val|
      next unless restaurant.attributes.include?(key)
      restaurant.send("#{key}=", val)
    end
    self.rejected = false
    self.accepted = true
    (restaurant.save! and save!) or raise
  end

  def reject!
    self.rejected = true
    self.accepted = false
    save! or raise
  end
end
