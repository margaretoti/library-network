require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:checkouts) }
    it { should have_many(:books).through(:checkouts) }
  end
end
