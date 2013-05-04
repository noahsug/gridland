Behavior = require('../coffee/behavior.coffee').Behavior
MoveAction = require('../coffee/move_action.coffee').MoveAction
util = require('../coffee/util.coffee').util
Position = require('../coffee/position.coffee').Position

class RandomMovementBehavior extends Behavior

  getAction: ->
    action = new MoveAction()
    action.setTarget @entity_
    pos = @getRandomAdjescentPos_()
    action.setDestination pos
    return action

  getRandomAdjescentPos_: ->
    possibleMoves = [ { x: 1, y: 0 }, { x: -1, y: 0 },
        { x: 0, y: 1 }, { x: 0, y: -1 } ]
    for move in util.shuffle possibleMoves
      newPos = Position.add @entity_.getPos(), move
      return newPos if @isValidPosition_ newPos
    return @entity_.getPos()

  isValidPosition_: (position) ->
    return @knowledge_.world.isInWorld(position) and
        @knowledge_.world.isEmpty(position)

exports.RandomMovementBehavior = RandomMovementBehavior
