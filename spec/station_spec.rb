require 'station'

describe Station do

  context 'on creation' do

    let(:subject) { Station.new("Ewell", 2) }

    it 'has a zone' do
      expect(subject.zone).to eq 2
    end

    it 'has a name' do
      expect(subject.name).to eq "Ewell"
    end

  end

end
