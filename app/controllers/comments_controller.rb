class CommentsController < ApplicationController

  load_and_authorize_resource

  def create
    save(:create) { @comment.save }
  end

  def update
    save(:update) { @comment.update_attributes(params[:comment]) }
  end

  private

  def save(op)
    notice = yield ? nil : "Failed to #{op} comment"
    redirect_to :back, :notice => notice
  end

end

