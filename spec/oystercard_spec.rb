require 'oystercard'


describe Oystercard do
  let(:station) { double :station }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { { entry_station: entry_station, exit_station: exit_station} }

  context "balance on card" do
    it 'has a balance of zero' do
      expect(subject.balance).to eq(0)
    end

    describe "#top_up" do
      it { is_expected.to respond_to(:top_up).with(1).argument }

      it "can top up the balance" do
        expect { subject.top_up(1) }.to change { subject.balance }.by 1
      end

      it "raises an error if the maximum balance is excceeded" do
        maximum_balance = Oystercard::MAXIMUM_BALANCE
        subject.top_up(maximum_balance)
        expect { subject.top_up 1}.to raise_error "Maximum balance of #{maximum_balance} exceeded"
      end

      it "reduces the balance by minimum fare, from #touch_out." do
        expect { subject.touch_out(exit_station)}.to change { subject.balance }.by(-1)
      end

    it "raises an error when you touch in with less than £1 balance." do
      expect { subject.touch_in(station) }.to raise_error("Below £#{Oystercard::MINIMUM_BALANCE}.")
    end

    it "knows where I've travelled from" do
      subject.top_up(20)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
    end
  end

  context "card is in a journey" do

    it 'can touch in' do
      subject.top_up(20)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

  end

  context "card is not in a journey" do

    it "has an empty list of journeys by default" do
      expect(subject.journeys).to be_empty
    end

    it 'is initially not in a journey' do
      expect(subject).to_not be_in_journey
    end

    it 'can touch out' do
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

    it "stores exit station" do
      subject.top_up(20)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end

    it "stores a journey" do
      subject.top_up(20)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys.count).to eq 1
    end

  end

end
