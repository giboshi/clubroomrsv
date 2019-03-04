class Circle < ApplicationRecord
  validates :name, presence: true
  has_secure_password
end
