class Oyster

  attr_reader :balance
  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(money)
    raise("Balance will exceed £#{MAX_BALANCE} maximum") if (@balance + money) > MAX_BALANCE

    @balance += money
  end

  def deduct(money)
    @balance -= money 
  end

end
