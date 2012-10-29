class TopicsController < ApplicationController

  load_resource :except => [:index, :show]
  authorize_resource

  before_filter :check_ace_editor, only: [:edit, :new]

  def index
    remember_or_recall_params :state, :campus, :order

    @topics = Topic.includes([:listeners,:lecturers]).filter_by_tags([params[:state] || 'open', params[:campus]].compact).scoped
    @topics = @topics.sort_by((params[:order] || :updated).to_s)
  end

  def show
    @topic = Topic.includes([:listeners,:lecturers,:comments]).find(params[:id])

    # clean notifications
    current_staff.notifications.where(:topic_id => @topic).delete_all
  end

  def create
    save('create', 'new') do
      @topic.save 
      @topic.observers << @topic.staff
    end
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

    if collection != 'observers' && method == 'push' && @topic.observers.where('staffs.id' => current_staff.id).limit(1).count == 0
      collection = [collection, 'observers']
    else
      collection = [collection]
    end

    if ['push', 'delete'].include?(method) && (collection - ['lecturers', 'listeners', 'observers'] == [])
      collection.uniq.each do |people|
        @topic.send(people).send(method, current_staff)
      end
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

  def check_ace_editor
    @use_ace = (current_staff.preferences.try { |p| p.editor == Preferences::EDITOR_OPTIONS.index(:ACE) })
  end

end
