class Oystercard

  attr_reader :balance

  DEFAULT_BALANCE = 0
  BALANCE_LIMIT = 90

  def initialize
    @balance = DEFAULT_BALANCE
  end

  def top_up(amount)
    fail "Maximum balance #{BALANCE_LIMIT} exceeded" if balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

end
