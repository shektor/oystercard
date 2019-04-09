class Oyster

  attr_reader :balance, :entry_station

  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(money)
    raise("Balance will exceed £#{MAX_BALANCE} maximum") if (@balance + money) > MAX_BALANCE

    @balance += money
  end

  def in_journey?
    !!entry_station
    # !entry_station.nil?
    # @entry_station ? true : false
  end

  def touch_in(station)
    raise "lower than minumin amount" if balance < MIN_FARE

    @entry_station = station
    @in_use = true
    "Touched in"
  end

  def touch_out
    deduct(MIN_FARE)
    @entry_station = nil
    @in_use = false
    "Touched out"
  end

  private

  def deduct(money)
    @balance -= money
  end
end
