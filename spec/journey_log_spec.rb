require 'journey_log'

describe JourneyLog do

  let(:journey) { double :journey_class }
  let(:entry_station) { double :station_class }
  let(:exit_station) { double :station_class }

  before do
    @subject = JourneyLog.new(journey)
  end

  it 'takes a journey object on creation' do
    expect(@subject.current_journey).to eq journey
  end

  it 'responds to #start with one parameter' do
    expect(@subject).to respond_to(:start).with(1).argument
  end

  it 'responds to #finish with one parameter' do
    expect(@subject).to respond_to(:finish).with(1).argument
  end

  it 'stores a journey' do
    allow(journey).to receive(:entry_station=)
    allow(journey).to receive(:finish)
    @subject.start(entry_station)
    @subject.finish(exit_station)
    expect(@subject.journeys.length).to eq 1
  end

end
