class EventsController < ApplicationController
  before_filter :find_event, :only => [ :show, :edit, :update, :destroy]
  def index
  	#@events = Event.all
    @events = Event.page(params[:page]).per(5)
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @events.to_xml }
      format.json { render :json => @events.to_json }
      format.atom { @feed_title = "My event list" } # index.atom.builder
    end
  end

  def new
    @event = Event.new
  end

  def create
    flash[:notice] = "event was successfully created"
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_url
    else
      render :action => :new
    end
  end

  def show
    @event = Event.find(params[:id])
    respond_to do |format|
      format.html { @page_title = @event.name } # show.html.erb
      format.xml # show.xml.builder
      format.json { render :json => { id: @event.id, name: @event.name }.to_json }
    end
  end

  def edit
  end

  def update
    if @event.update_attributes(event_params)
      redirect_to event_url(@event)
    else
      render :action => :edit
    end
    flash[:notice] = "event was successfully updated"
  end

  def destroy
  	flash[:alert] = "event was successfully deleted"
    @event.destroy
    redirect_to events_url
  end

  protected
    def find_event
      @event = Event.find(params[:id])
    end
    def event_params
      params.require(:event).permit(:name, :description)
    end
end
