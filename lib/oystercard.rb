require_relative 'journey'
require_relative 'station'

class Oystercard

  attr_reader :balance, :journeys

  DEFAULT_BALANCE = 0
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @current_journey = nil
    @journeys = []
  end

  def top_up(amount)
    fail "Maximum balance #{BALANCE_LIMIT} exceeded" if balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    fail "You require a min of £#{MINIMUM_FARE} to travel" if balance < MINIMUM_FARE
    @current_journey = Journey.new(entry_station)
  end

  def in_journey?
    !!@current_journey
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @current_journey.finish(exit_station)
    save_journey
  end

  def save_journey
    @journeys.push(@current_journey)
    @current_journey = nil
  end


  private

  def deduct(amount)
    @balance -= amount
  end

end
