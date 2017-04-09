class RemoveCharacterJob < ApplicationJob
  queue_as :default

  def perform(character)
    ActionCable.server.broadcast 'characters', character.id
  end
end
