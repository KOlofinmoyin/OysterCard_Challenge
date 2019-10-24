class Oystercard

MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1

  attr_reader :balance, :entry_station, :exit_station, :journeys, :journey_history

  def initialize
    @balance = 0
    @in_journey = false
    @journeys = []
    @journey = {}
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
    @exit_station = station
    @journey[@entry_station] = @exit_station
    @journeys << @journey
    @entry_station = nil
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
