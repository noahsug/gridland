Action = require('../coffee/action.coffee').Action

class MoveAction extends Action
  constructor: ->

  setDestination: (destination) ->
    @destination_ = x: destination.x, y: destination.y

  getDestination: ->
    @destination_

  actOn: (world) ->
    throw "destination not defined" unless @destination_?
    if world.isEmpty(@destination_)
      world.remove @source_
      @source_.setPos @destination_
      world.add @source_

exports.MoveAction = MoveAction
