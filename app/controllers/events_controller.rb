# frozen_string_literal: true

# Events Controller
class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/calendar_feed.ics
  def calendar_feed
    events = Event.all
    events.each do |event|
      cal.add_event(event.to_ics)
    end

    cal.publish

    respond_to do |format|
      format.ics do
        render plain: cal.to_ical, content_type: 'text/calendar'
      end
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show; end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit; end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html do
          redirect_to @event,
                      notice: 'Event was successfully created.'
        end
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json do
          render json: @event.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html do
          redirect_to @event,
                      notice: 'Event was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json do
          render json: @event.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html do
        redirect_to events_url,
                    notice: 'Event was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  def cal
    Icalendar::Calendar.new
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :start_date, :end_date, :summary)
  end
end
