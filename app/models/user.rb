class User < ApplicationRecord
  include Clearance::User

  validates :name, presence: true
  validates :admin, presence: true
end
