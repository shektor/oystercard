require 'oyster'

describe Oyster do
  context 'initialize' do
    it { expect(subject).to have_attributes(:balance => 0) }
  end
end
