require 'rails_helper'

describe Book, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) }

    subject { FactoryGirl.build(:book) }
    it { should validate_uniqueness_of(:title).case_insensitive }
  end

  describe 'associations' do
    it { should have_many(:checkouts) }
    it { should have_many(:users).through(:checkouts) }
  end
end
