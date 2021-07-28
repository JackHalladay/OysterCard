require "station"

class OysterCard

attr_reader :balance
attr_reader :entry_station
attr_reader :exit_station
attr_reader :journey_history

MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1

  def initialize
    @entry_station = nil
    @balance = 0
    @journey_history = []
  end

  def top_up(up_amount)
    @up_amount = up_amount
    fail "Maximum balance of #{MAXIMUM_BALANCE} has been exceeded" if self.exceeded?
    @balance += @up_amount
  end

  def touch_in(entry_station)
    @entry_station = entry_station
    fail "You do not have the minimum amount of #{MINIMUM_BALANCE}" if self.minimum?
  end
  
  def touch_out(exit_station)
    @exit_station = exit_station
    deduct(MINIMUM_BALANCE)
    add_journey
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private
  def exceeded?
    (@balance + @up_amount) > MAXIMUM_BALANCE
  end

  def minimum?
    @balance < MINIMUM_BALANCE
  end

  def deduct(down_amount)
    @balance -= down_amount
  end

  def add_journey
    @journey_history << {entry: @entry_station, exit: @exit_station}
  end

end