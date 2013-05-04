class Renderer
  constructor: (@game_) ->
    @world_ = @game_.getWorld()
    @game_.on 'world_updated', (actions) => @renderWorld_ actions

  renderWorld_: (actions) ->

  beginRendering: ->

exports.Renderer = Renderer
