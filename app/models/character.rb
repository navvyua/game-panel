class Character < ApplicationRecord
  belongs_to :user

  validates_presence_of :first_name, :last_name, :age, :biography
  validates :age, numericality: { only_integer: true, greater_than: 10, less_than: 100 }

  enum status: [:validating, :denied, :validated, :banned]

  acts_as_paranoid
end
