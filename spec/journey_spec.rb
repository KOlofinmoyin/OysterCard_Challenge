require 'journey'

describe Journey do
  subject(:trip) { described_class.new }
  let(:tube_station) { double :tube_station, zone: 1}

  it "knows if a journey is not complete" do
  expect(trip).not_to be_complete
  end

  it 'has a penalty fare by default' do
    expect(trip.fare).to eq Journey::PENALTY_FARE
  end

  it "returns itself when exiting a journey" do
    expect(trip.finish(tube_station)).to eq(trip)
  end

end
#
