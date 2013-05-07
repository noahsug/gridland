class Renderer
  constructor: (@game_) ->
    @world_ = @game_.getWorld()
    @game_.on 'world_updated', (actions) => @onWorldUpdated_ actions

  onWorldUpdated_: (actions) ->

  beginRendering: ->

exports.Renderer = Renderer
