class Oystercard

  attr_reader :balance, :in_journey
  alias_method :in_journey?, :in_journey

  DEFAULT_BALANCE = 0
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @in_journey = false
  end

  def top_up(amount)
    fail "Maximum balance #{BALANCE_LIMIT} exceeded" if balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    fail "You require a min of £#{MINIMUM_FARE} to travel" if balance < MINIMUM_FARE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
