Action = require('../coffee/action.coffee').Action

class MoveAction extends Action
  constructor: ->

  setDestination: (@destination_) ->

  setTarget: (@target_) ->

  actOn: (world) ->
    if world.isEmpty(@destination_)
      world.remove @target_
      @target_.setPos @destination_.x, @destination_.y
      world.add @target_

exports.MoveAction = MoveAction
