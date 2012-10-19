class TopicsController < ApplicationController

  load_and_authorize_resource

  def index
    @topics = @topics.filter_by_tags([params[:state] || 'open', params[:campus]].compact).scoped
    @topics = @topics.sort_by((params[:order] || :updated).to_s)
  end

  def show
  end

  def create
    save('create', 'new') { @topic.save }
  end

  def new
  end

  def edit
  end

  def update
    save('update', 'edit') { @topic.update_attributes(params[:topic]) }
  end

  def destroy
    save('delete') { @topic.destroy }
  end

  def vote
    current_staff.vote_for(@topic)
    redirect_to :back
  end

  def unvote
    current_staff.unvote_for(@topic)
    redirect_to :back
  end

  private

  def save(op, view=nil)
    if yield 
      redirect_to @topic
    else
      notice = "Failed to #{op} topic"

      if view
        render view
      else
        redirect_to :back, :notice => notice
      end
    end
  end

end
