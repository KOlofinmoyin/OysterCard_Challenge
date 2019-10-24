require 'journey'

describe Journey do
  let(:tube_station) { double :tube_station, zone: 1}

  it "knows if a journey is not complete" do
  expect(subject).not_to be_complete
  end

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it "returns itself when exiting a journey" do
    expect(subject.finish(tube_station)).to eq(subject)
  end

  context 'given an entry station' do
    subject (:trip) { described_class.new(entry_station: tube_station) }

    it 'has an entry station' do
      expect(trip.entry_station).to eq tube_station
    end

  end

end
#
