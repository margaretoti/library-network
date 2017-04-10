require 'rails_helper'

describe Checkout, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end
end
