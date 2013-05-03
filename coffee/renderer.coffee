class Renderer
  constructor: ->

  setWorld: (@world_) ->

  listenForEvents: (game) ->
    game.on 'entity_added', @onEntityAdded_
    game.on 'entity_removed', @onEntityRemoved_
    game.on 'actions', @renderActions_

  onEntityRemoved_: (entity) =>


  onEntityAdded_: (entity) =>


  renderActions_: (actions) =>

  draw: ->

exports.Renderer = Renderer
