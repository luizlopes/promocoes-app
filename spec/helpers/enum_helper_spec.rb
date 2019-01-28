require 'rails_helper'

describe EnumHelper do
  describe '.enum' do
    it 'renders errors if status not given' do
      expect(enum(nil)).to eq 'erro'
    end
  end
end
