class OysterCard
attr_reader :balance
MAXIMUM_BALANCE = 90
  def initialize
    @balance = 0
  end

  def top_up(amount)
    @amount = amount
    fail "Maximum balance of #{MAXIMUM_BALANCE} has been exceeded" if self.exceeded?
    @balance += @amount
  end

  private
  def exceeded?
    (@balance + @amount) > MAXIMUM_BALANCE
  end
end