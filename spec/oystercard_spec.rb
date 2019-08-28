require 'oystercard'

describe Oystercard do
  it 'expects the oystercard to initialize with a balance of 0' do
    expect(subject.balance).to eq (Oystercard::DEFAULTBALANCE)
  end

  describe '#top_up' do
    it 'tops up the balance with 5 ' do
      expect{ subject.top_up 5 }.to change{ subject.balance }.by 5
    end

    it "expects to throw an exception if topup amount + balance exceeds limit" do
      expect { subject.top_up(Oystercard::LIMIT + 1) }.to raise_error "Above limit value of #{Oystercard::LIMIT}"
    end
  end

  describe '#deduct'do
    it "deducts the argument entered from the balance" do
      subject.top_up(60)
      expect{ subject.deduct(5) }.to change{ subject.balance }.by -5
    end
  end

  describe '#in_journey?' do
    it "expects not to be in journey" do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it "expects boolean variable journey to change from false to true" do
      subject.top_up(5)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it "raises an error if balance insufficient" do
      expect { subject.touch_in }.to raise_error "Insufficient funds"
    end
end

  describe '#touch_out' do
    it "expects boolean variable journey to change from true to false" do
      subject.top_up(5)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

end
