require 'station'
require 'oystercard'

describe Station do
  
  it "initialises with a name" do
    subject = Station.new("Gabriel", 1)
    expect(subject).to respond_to(:name)
  end

  it "initialises with a zone" do
    bank = Station.new("Gabriel", 1)
    expect(bank.zone).to eq (1)
  end
end
