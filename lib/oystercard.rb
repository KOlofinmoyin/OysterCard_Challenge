class Oystercard

MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1

  attr_reader :balance, :entry_station, :exit_station

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Maximum balance of 90 exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    raise "Below £1." if @balance <= MINIMUM_BALANCE

    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_BALANCE)
    @entry_station = nil
    @exit_station = station
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
