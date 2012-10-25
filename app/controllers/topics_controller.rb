class TopicsController < ApplicationController

  load_resource :except => [:index, :show]
  authorize_resource

  def index
    @topics = Topic.includes([:listeners,:lecturers]).filter_by_tags([params[:state] || 'open', params[:campus]].compact).scoped
    @topics = @topics.sort_by((params[:order] || :updated).to_s)
  end

  def show
    # includes([:listeners,:lecturers,:comments])
    @topic = Topic.find(params[:id])
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

  def register
    collection, method = params[:do].split('_')

    if ['push', 'delete'].include?(method) && ['lecturers', 'listeners'].include?(collection)
      @topic.send(collection).send(method, current_staff)
      expire_cache
    else
      raise RuntimeError.new("Unknown register action")
    end

    redirect_to :back
  end

  private

  def save(op, view=nil)
    if yield 
      # expire index page preview
      expire_cache
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

  def expire_cache
    # expire index page preview
    expire_fragment(:controller => 'topics', :action => 'index', :id => @topic.id)
  end

end
