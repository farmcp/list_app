class EditRequestsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_only, except: [:create]

  def index
    @edit_requests = EditRequest.where(rejected: false)
  end

  def show
    @edit_request = EditRequest.find(params[:id])
  end

  def create
    request_params = params[:restaurant]
    restaurant = Restaurant.find(params[:edit_request].delete(:restaurant_id))
    request_params.each do |key, value|
      request_params.delete key if restaurant.attributes[key.to_s].to_s == value
    end
    @edit_request = current_user.edit_requests.build(restaurant: restaurant, params: request_params.to_json)
    @edit_request.save!
    redirect_to restaurant_path(restaurant), notice: 'Edit request submitted! Thank you.'
  end

  def accept
    @edit_request = EditRequest.find(params[:id])
    @edit_request.accept!
  end

  def reject
    @edit_request = EditRequest.find(params[:id])
    @edit_request.reject!
  end

  private

  def admin_only
    redirect_to root_path unless current_user.admin?
  end
end
