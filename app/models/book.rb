class Book < ApplicationRecord
  has_many :checkouts
  has_many :users, through: :checkouts

  validates :title, presence: true, uniqueness: { case_sensitive: false}
  validates :author, presence: true

  def self.available
    includes(:checkouts).where(checkouts: { id: nil })
  end

  def self.unavailable
    includes(:checkouts).where.not(checkouts: { id: nil })
  end
end
