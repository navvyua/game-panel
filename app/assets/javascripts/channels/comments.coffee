App.comments = App.cable.subscriptions.create "CommentsChannel",
  collection: -> $('#comments')

  connected: ->
    setTimeout =>
      @followCurrentCommentable()
    , 1000

  disconnected: ->

  followCurrentCommentable: ->
    commentableId = @collection().data('commentable-id')
    commentableType = @collection().data('commentable-type')

    if commentableId
      @perform 'follow', commentable_id: commentableId, commentable_type: commentableType
    else
      @perform 'unfollow'

  received: (comment) ->
    @collection().append(comment)
