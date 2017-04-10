class User < ApplicationRecord
  include Clearance::User

  has_many :checkouts
  has_many :books, through: :checkouts

  validates :name, presence: true
end
