# frozen_string_literal: true

class Event < ApplicationRecord
  def to_ics
    event = Icalendar::Event.new
    event.dtstart = start_date
    event.dtend = end_date
    event.summary = name
    event.description = summary
    event
  end
end
