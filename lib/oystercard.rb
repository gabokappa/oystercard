class Oystercard

  LIMIT = 90
  DEFAULTBALANCE = 0
  MINIMUMFARE = 1

  def initialize
    @balance = DEFAULTBALANCE
    @journey = false
  end

  def top_up(money)
    fail "Above limit value of #{LIMIT}" unless balance + money <= LIMIT
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def in_journey?
    @journey
  end

  def touch_in
    fail "Insufficient funds" if balance < MINIMUMFARE
    @journey = true
  end

  def touch_out
    deduct(MINIMUMFARE)
    # @balance -= MINIMUMFARE
    @journey = false
  end
  attr_reader :balance

   private 

  def deduct(money)
    @balance -= money
  end

end
