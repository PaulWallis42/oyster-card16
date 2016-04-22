require 'oystercard'


describe Oystercard do

    let(:station) { double :station }

    it 'has a zero balance on creation' do
      expect(subject.balance).to eq Oystercard::DEFAULT_BALANCE
    end

    it 'is not in_journey on creation' do
      expect(subject).not_to be_in_journey
    end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument } #would remove as covered below, reference only

    it 'can top up the balance' do
      expect { subject.top_up 1 }.to change { subject.balance }.by 1
    end

    it 'raises an error if the maximum limit is exceeded' do
      maximum_balance = Oystercard::BALANCE_LIMIT
      subject.top_up(maximum_balance)
      expect { subject.top_up(1) }.to raise_error "Maximum balance #{maximum_balance} exceeded"
    end

  end

=begin (This test now fails due to being private but is covered in other tests anyway so could be deleted)
   it { is_expected.to respond_to(:deduct).with(1).argument } #would remove as covered below, reference only

    it 'deducts from the balance' do
    subject.top_up(Oystercard::BALANCE_LIMIT)
    subject.deduct(20)
    expect(subject.balance).to eq 70
    end

  end
=end

  describe '#touch_in' do

    it { is_expected.to respond_to(:touch_in) }

    it 'after touching in, card shows that it is in use' do
      subject.top_up(Oystercard::BALANCE_LIMIT)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'will not let you touch in if insufficient balance' do
      expect { subject.touch_in(station) }.to raise_error "You require a min of £#{Oystercard::MINIMUM_FARE} to travel"
    end

    it 'stores the entry station' do
      subject.top_up(Oystercard::BALANCE_LIMIT)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

  end

  describe '#touch_out' do

    before do
      subject.top_up(Oystercard::BALANCE_LIMIT)
      subject.touch_in(station)
    end

    it { is_expected.to respond_to(:touch_out) }

    it 'after touching out, card shows it is not in use' do
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it 'deducts fare from the balance' do
      expect { subject.touch_out }.to change{ subject.balance }.by(-1)
    end

    it 'removes entry station when touch out' do
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end

  end

end
