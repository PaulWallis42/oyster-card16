class Oystercard

  attr_reader :balance, :entry_station
#  alias_method :in_journey?, :in_journey

  DEFAULT_BALANCE = 0
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @in_journey = false
    @entry_station
  end

  def top_up(amount)
    fail "Maximum balance #{BALANCE_LIMIT} exceeded" if balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "You require a min of £#{MINIMUM_FARE} to travel" if balance < MINIMUM_FARE
    @in_journey = true
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end


end
