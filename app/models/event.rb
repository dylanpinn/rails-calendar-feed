class Event < ApplicationRecord
  def to_ics
    event = Icalendar::Event.new
    event.dtstart = self.start_date
    event.dtend = self.end_date
    event.summary = self.name
    event.description = self.summary
    return event
  end
end
