App.characters = App.cable.subscriptions.create "CharactersChannel",
  collection: -> $('#characters')

  connected: ->
    setTimeout =>
      @followCharacters()
    , 1000

  disconnected: ->

  followCharacters: ->
    if window.location.pathname == '/admin/characters'
      @perform 'follow'
    else
      @perform 'unfollow'

  received: (character_id) ->
    character = @collection().find('[data-character-id="' + character_id + '"]')
    character.fadeOut 'fast', ->
      character.remove()
