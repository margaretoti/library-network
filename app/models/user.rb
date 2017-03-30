class User < ApplicationRecord
  include Clearance::User

  validates :name, presence: true
  validates :admin, :inclusion => { :in => [true, false] }
end
