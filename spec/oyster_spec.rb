require 'oyster'

describe Oyster do
  let(:station) { double :station }

  context '#initialize' do
    it { expect(subject).to have_attributes(balance: 0) }
  end

  context '#top up' do
    oyster = Oyster.new
    it { expect(oyster.top_up(5)).to eq 5 }
    it { expect(oyster.top_up(10)).to eq 15 }
  end
  context 'max balance exceeded' do
    it 'raises error' do
      maximum_balance = Oyster::MAX_BALANCE
      subject.top_up(maximum_balance)
      expect { expect(subject.top_up(1)) }.to raise_error("Balance will exceed £#{maximum_balance} maximum")
    end
  end

  # context '#deduct' do
  #   it 'deducts money' do
  #     oyster = Oyster.new
  #     oyster.top_up(10)
  #     expect { oyster.deduct 5 }.to change { oyster.balance }.by(-5)
  #   end
  # end

  context 'travelling' do
    oyster = Oyster.new
    oyster.top_up(described_class::MIN_FARE)
    it '#in_journey' do
      expect(oyster).not_to be_in_journey
    end
    it '#touch_in' do
      oyster.touch_in(station)
      expect(oyster).to be_in_journey
    end
    it '#touch_out' do
      oyster.touch_out
      expect(oyster).not_to be_in_journey
    end
  end

  context 'touch_in' do
    message = 'lower than minumin amount'
    it 'raise an error when touch in with new card' do
      expect { subject.touch_in(station) }.to raise_error(message)
    end

    it 'raise an error when the balance is lower than minimum when touch in' do
        subject.top_up(described_class::MIN_FARE)
        subject.touch_in(station)
        subject.touch_out
      expect { subject.touch_in(station) }.to raise_error(message)
    end

    it 'to store the entry station' do
      subject.top_up(described_class::MIN_FARE)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

  context '#touch_out' do
    it 'deducts the minimum fare' do
      subject.top_up(5)
      expect { subject.touch_out }.to change { subject.balance }.by(-described_class::MIN_FARE)
    end

    it 'to forget the entry station' do
      subject.top_up(described_class::MIN_FARE)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end
  end
end
