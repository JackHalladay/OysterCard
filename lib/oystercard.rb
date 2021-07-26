class OysterCard
attr_reader :balance
MAXIMUM_BALANCE = 90
  def initialize
    @balance = 0
  end

  def top_up(up_amount)
    @up_amount = up_amount
    fail "Maximum balance of #{MAXIMUM_BALANCE} has been exceeded" if self.exceeded?
    @balance += @up_amount
  end

  def deduct(down_amount)
    @balance -= down_amount
  end

  def touch_in
    @journey = true
  end

  def in_journey?
    @journey
  end

  private
  def exceeded?
    (@balance + @up_amount) > MAXIMUM_BALANCE
  end
end