require 'oystercard'

describe Oystercard do
  let(:station){ double :station }
  it 'expects the oystercard to initialize with a balance of 0' do
    expect(subject.balance).to eq (Oystercard::DEFAULTBALANCE)
  end

  it "initializes with an empty journey history" do
    expect(subject.journey_history).to be_empty
  end

  describe '#top_up' do
    it 'tops up the balance with 5 ' do
      expect{ subject.top_up 5 }.to change{ subject.balance }.by 5
    end

    it "expects to throw an exception if topup amount + balance exceeds limit" do
      expect { subject.top_up(Oystercard::LIMIT + 1) }.to raise_error "Above limit value of #{Oystercard::LIMIT}"
    end
  end

  # describe '#deduct'do
  #   it "deducts the argument entered from the balance" do
  #     subject.top_up(60)
  #     expect{ subject.deduct(5) }.to change{ subject.balance }.by -5
  #   end
  # end

  describe '#in_journey?' do
    it "expects not to be in journey" do
      expect(subject.in_journey?).to eq false
    end
  end

  describe '#touch_in' do
    it "expects boolean variable journey to change from false to true" do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it "remembers the entry station" do
      subject.top_up(5)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

    it "raises an error if balance insufficient" do
      expect { subject.touch_in(station) }.to raise_error "Insufficient funds"
    end
end

  describe '#touch_out' do
    it "expects boolean variable journey to change from true to false" do
      subject.top_up(5)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end
    it  "deducts balance by 1" do
      subject.top_up(5)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change{ subject.balance }.by(-Oystercard::MINIMUMFARE)
    end
    it "changes entry_station to nil" do
      subject.top_up(5)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.entry_station).to eq nil
    end
    it "takes an exit station" do
      expect(subject).to respond_to(:touch_out).with(1).argument
    end
    it "stores journey history" do
      subject.top_up(5)
      subject.touch_in(station)
      subject.touch_out("Bank")
      expect(subject.journey_history).to eq ({station => "Bank"})
    end

  end

end
