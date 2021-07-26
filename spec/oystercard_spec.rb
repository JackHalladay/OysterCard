require "OysterCard"

describe OysterCard do

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

  it "can have money deducted" do
    subject.top_up(30)
    expect{subject.deduct(10)}.to change{subject.balance}.by -10
  end
end