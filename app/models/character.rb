class Character < ApplicationRecord
  belongs_to :user

  validates_presence_of :first_name, :last_name, :age, :biography
  validates :age, numericality: { only_integer: true, greater_than: 10, less_than: 100 }

  acts_as_paranoid

  enum status: [:validating, :denied, :validated, :banned]

  def full_name
    "#{first_name} #{last_name}"
  end
end
