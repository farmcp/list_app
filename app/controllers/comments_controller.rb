class CommentsController < ApplicationController
  def create
    if current_user && signed_in?
      restaurant_id = params[:id]
      user_id = current_user.id
      @comment = Comment.create(:restaurant_id => restaurant_id, :user_id => user_id, :body => params[:comment][:body])
      if @comment.save
        redirect_to :back
      else
        flash[:error] = "Something went wrong with your post. Please try again later :("
        redirect_to current_user
      end
    end
  end
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to :back
  end
end