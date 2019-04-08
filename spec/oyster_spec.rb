require 'oyster'

describe Oyster do
  context '#initialize' do
    it { expect(subject).to have_attributes(:balance => 0) }
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

  context '#deduct' do
    it 'deducts money' do
      oyster = Oyster.new
      oyster.top_up(10)
      expect { oyster.deduct 5 }.to change { oyster.balance }.by -5
    end
  end

  context 'travelling' do
    oyster = Oyster.new
    it '#in_journey' do
      expect(oyster).not_to be_in_journey
    end
    it '#touch_in' do
      oyster.touch_in
      expect(oyster).to be_in_journey
    end
    it '#touch_out' do
      oyster.touch_out
      expect(oyster).not_to be_in_journey
    end
  end

  # context '#in_journey?' do
  #   it { expect(subject.in_journey?).to eql false }
  # end
  # context '#touch_in' do
  #   oyster = Oyster.new
  #   oyster.touch_in
  #   it { expect(oyster.in_journey?).to eql true }
  # end
  # context '#touch_in' do
  #   oyster = Oyster.new
  #   oyster.touch_in
  #   oyster.touch_out
  #   it { expect(oyster.in_journey?).to eql false }
  # end

end
