class Character < ApplicationRecord
  belongs_to :user

  enum status: [:validating, :denied, :validated, :banned]

  validates_presence_of :first_name, :last_name, :age, :biography
  validates :age, numericality: { only_integer: true, greater_than: 10, less_than: 100 }

  def full_name
    "#{first_name} #{last_name}"
  end
end
