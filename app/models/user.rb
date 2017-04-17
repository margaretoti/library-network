class User < ApplicationRecord
  include Clearance::User

  has_many :checkouts
  has_many :books, through: :checkouts

  validates :name, presence: true

  def total_fines
    total = checkouts.inject(0) { |total, checkout| total + checkout.fine }
    total = sprintf('%.2f', total)
  end
end
