require_relative 'journey'

class JourneyLog

  attr_reader :current_journey

  def initialize(journey_class)
    @current_journey = journey_class
    @journeys = []
  end

  def start(station_class)
    @current_journey.entry_station = station_class
  end

  def finish(station_class)
    @current_journey.finish(station_class)
    store_journey
  end

  def store_journey
    @journeys << @current_journey
    @current_journey = nil
  end

  def journeys
    @journeys.dup #returns a copy not the original to prevent editing of original
  end

end
