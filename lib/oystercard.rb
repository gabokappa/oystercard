class Oystercard

  LIMIT = 90
  DEFAULTBALANCE = 0
  MINIMUMFARE = 1
attr_reader :balance, :entry_station, :journey_history
  def initialize
    @balance = DEFAULTBALANCE
    # @journey = false
    @entry_station = nil
    @journey_history = {}
  end

  def top_up(money)
    fail "Above limit value of #{LIMIT}" unless balance + money <= LIMIT
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def in_journey?
    !!entry_station
  # @entry_station != nil
  end

  def touch_in(station)
    fail "Insufficient funds" if balance < MINIMUMFARE

    @entry_station = station
    # @journey = true
  end

  def touch_out(station)
    deduct(MINIMUMFARE)
    @journey_history[@entry_station] = station 
    @entry_station = nil
    # @journey = false

  end


   private

  def deduct(money)
    @balance -= money
  end

end
