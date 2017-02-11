module CharacterHelper
  def validating_characters_count
    Character.validating.count
  end
end
