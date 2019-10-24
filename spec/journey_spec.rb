require 'journey'

describe Journey do
  subject(:trip) { described_class.new }

  it "knows if a journey is not complete" do
  expect(trip).not_to be_complete
  end

  it 'has a penalty fare by default' do
    expect(trip.fare).to eq Journey::PENALTY_FARE
  end

end
#
