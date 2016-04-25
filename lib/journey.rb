class Journey

  PENALTY_FARE = 6
  STANDARD_FARE = 1

  attr_reader :journeys, :exit_station
  attr_accessor :entry_station

  def initialize(entry_station=nil)
    @entry_station = entry_station
    @exit_station
  end

  def complete?
    entry_station && exit_station ? true : false
  end

  def fare
    !exit_station ? PENALTY_FARE : STANDARD_FARE
  end

  def finish(station)
    @exit_station = station
    self
  end

end
