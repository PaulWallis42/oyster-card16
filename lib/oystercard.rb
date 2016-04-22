class Oystercard

  attr_reader :balance, :entry_station, :journeys, :exit_station

  DEFAULT_BALANCE = 0
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @entry_station
    @exit_station
    @journeys = {}
  end

  def top_up(amount)
    fail "Maximum balance #{BALANCE_LIMIT} exceeded" if balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "You require a min of £#{MINIMUM_FARE} to travel" if balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    save_journey
    @entry_station = nil
    @exit_station = nil
  end

  def in_journey?
    !!entry_station
  end

  def save_journey
    @journeys[:"journey#{@journeys.length}"] = [entry_station, exit_station]
  end

  private

  def deduct(amount)
    @balance -= amount
  end


end
