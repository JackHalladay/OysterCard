require "OysterCard"

describe OysterCard do

  let(:entry_station){double :entry_station}
  let(:exit_station){double :exit_station}
  let(:journey){ {entry: entry_station, exit: exit_station} }

  it "has a balance" do
    expect(subject.balance).to eq(0)
  end
  
  it 'can top up the balance' do
    expect{ subject.top_up(1) }.to change{ subject.balance }.by 1
  end

  it "won't exceed maximum balance" do
    maximum_balance = OysterCard::MAXIMUM_BALANCE
    subject.top_up(maximum_balance)
    expect{subject.top_up(1)}.to raise_error("Maximum balance of #{maximum_balance} has been exceeded")
  end

  # it "can have money deducted" do
  #   subject.top_up(30)
  #   expect{subject.deduct(10)}.to change{subject.balance}.by -10
  # end

  it "can log touching in" do
    subject.top_up(5)
    subject.touch_in(entry_station)
    expect(subject.in_journey?).to eq(true)
  end

  it "can log touching out" do
    subject.touch_out(exit_station)
    expect(subject.in_journey?).to eq(false)
  end

  it "needs a minimum of £1" do
    minimum_amount = OysterCard::MINIMUM_BALANCE
    expect{subject.touch_in(entry_station)}.to raise_error("You do not have the minimum amount of #{minimum_amount}")
  end

  it "dedcuts money on touch out" do
    subject.top_up(5)
    subject.touch_in(entry_station)
    expect{subject.touch_out(exit_station)}.to change{subject.balance}.by(-OysterCard::MINIMUM_BALANCE)   
  end

  it "stores a journey" do
    subject.top_up(5)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journey_history).to include journey
  end

end
