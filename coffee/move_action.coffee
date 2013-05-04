Action = require('../coffee/action.coffee').Action

class MoveAction extends Action
  constructor: ->

  setDestination: (destination) ->
    @destination_ = x: destination.x, y: destination.y

  actOn: (world) ->
    throw "destination not defined" unless @destination_?
    if world.isEmpty(@destination_)
      world.remove @target_
      @target_.setPos @destination_
      world.add @target_

exports.MoveAction = MoveAction
