class Character < ApplicationRecord
  belongs_to :user

  has_many :reports

  validates_presence_of :first_name, :last_name, :age, :biography
  validates :age, numericality: { only_integer: true, greater_than: 10, less_than: 100 }

  enum status: [:validating, :denied, :validated, :banned]

  acts_as_paranoid

  scope :autocomplete_find, lambda { |name|
    name.downcase!

    if name.include?(' ')
      name_parts = name.split(' ')
      find_by_full_name(name_parts)
    else
      find_by_one_part_of_name(name)
    end
  }

  def full_name
    "#{first_name} #{last_name}"
  end

  class << self
    private

    def find_by_full_name(name_parts)
      where(
        'LOWER(characters.first_name) LIKE ? AND LOWER(characters.last_name) LIKE ?',
        "%#{name_parts[0]}%", "%#{name_parts[1]}%"
      ).order(:first_name)
    end

    def find_by_one_part_of_name(name)
      where(
        'LOWER(characters.first_name) LIKE ? OR LOWER(characters.last_name) LIKE ?',
        "%#{name}%", "%#{name}%"
      ).order(:first_name)
    end
  end
end
