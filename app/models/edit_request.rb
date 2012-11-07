class EditRequest < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  attr_accessible :approved, :params, :restaurant

  validates_presence_of :user_id, :restaurant_id, :params

  def parsed_params
    @parsed_params ||= JSON.load(params)
  end

  def diff(key)
    before = parsed_params[key].to_s
    after = restaurant.attributes[key].to_s
    Differ.diff_by_line(before, after)
  end
end
