Entity = require('../coffee/entity.coffee').Entity

class World

  @EMPTY = new Entity

  constructor: (@width_, @height_) ->
    @grid_ = (World.EMPTY for i in [1..@width_ * @height_])

  get: (pos) ->
    @grid_[@getGridIndex_(pos)]

  set: (pos, value) ->
    @grid_[@getGridIndex_(pos)] = value

  getWidth: ->
    @width_

  getHeight: ->
    @height_

  isEmpty: (pos) ->
    @get(pos).getType() is Entity.Type.Empty

  isInWorld: (pos) ->
    return (0 <= pos.x < @width_) and (0 <= pos.y < @height_)

  add: (entity) ->
    @set entity.getPos(), entity

  remove: (entity) ->
    if @get(entity.getPos()) is entity
      @set entity.getPos(), World.EMPTY

  getWidth: ->
    @width_

  getHeight: ->
    @height_

  getGridIndex_: (pos) ->
    pos.y * @width_ + pos.x

exports.World = World
