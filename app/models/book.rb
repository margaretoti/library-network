class Book < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: false}
  validates :author, presence: true
end
