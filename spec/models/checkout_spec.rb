require 'rails_helper'

describe Checkout, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:book) }

    subject { FactoryGirl.build(:checkout) }
    it { should validate_uniqueness_of(:book) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end
end
