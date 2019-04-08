require 'oyster'

describe Oyster do
  oyster = Oyster.new

  context '#initialize' do
    it { expect(subject).to have_attributes(:balance => 0) }
  end

  context '#top up' do
    it { expect(oyster.top_up(5)).to eq 5 }
    it { expect(oyster.top_up(10)).to eq 15 }
  end
end
