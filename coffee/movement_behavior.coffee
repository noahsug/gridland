Behavior = require('../coffee/behavior.coffee').Behavior
MoveAction = require('../coffee/move_action.coffee').MoveAction
Position = require('../coffee/position.coffee').Position

class MovementBehavior extends Behavior

  getAction: ->
    action = new MoveAction()
    action.setSource @entity_
    destination = @getDestination_()
    return if Position.equals destination, @entity_.getPos()
    action.setDestination destination
    return action

  isValidPosition_: (position) ->
    return @knowledge_.world.contains(position) and
        @knowledge_.world.isEmpty(position)

exports.MovementBehavior = MovementBehavior
