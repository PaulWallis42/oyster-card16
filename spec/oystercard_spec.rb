require 'oystercard'

describe Oystercard do

  it 'has a zero balance on creation' do
    expect(subject.balance).to eq Oystercard::DEFAULT_BALANCE
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

  describe '#deduct' do

    it { is_expected.to respond_to(:deduct).with(1).argument } #would remove as covered below, reference only

    it 'deducts from the balance' do
    subject.top_up(Oystercard::BALANCE_LIMIT)
    subject.deduct(20)
    expect(subject.balance).to eq 70
    end

  end
end
