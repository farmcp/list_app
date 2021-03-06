class EditRequestsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_only, except: [:create]

  def index
    @edit_requests = EditRequest.needs_review
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
    redirect_to restaurant_path(@edit_request.restaurant), notice: 'accepted!'
  end

  def reject
    @edit_request = EditRequest.find(params[:id])
    @edit_request.reject!
    redirect_to edit_requests_path, notice: 'rejected!'
  end
end
