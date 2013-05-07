class Renderer
  constructor: (@world_) ->

  listenToGameEvents: (game) ->
    game.on 'world_updated', (actions) => @onWorldUpdated_ actions

  onWorldUpdated_: (actions) ->

  beginRendering: ->

exports.Renderer = Renderer
