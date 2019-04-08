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
      subject.top_up(90)
      expect { expect(subject.top_up(1)) }.to raise_error("Balance will exceed £#{Oyster::MAX_BALANCE} maximum")
    end
  end
end
