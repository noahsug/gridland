MovementBehavior = require('../coffee/movement_behavior.coffee').MovementBehavior
Position = require('../coffee/position.coffee').Position
util = require('../coffee/util.coffee').util

class RandomMovementBehavior extends MovementBehavior

  getDestination_: ->
    possibleMoves = [ { x: 1, y: 0 }, { x: -1, y: 0 },
        { x: 0, y: 1 }, { x: 0, y: -1 } ]
    for move in util.shuffle possibleMoves
      newPos = Position.add @entity_.getPos(), move
      return newPos if @isValidPosition_ newPos
    return @entity_.getPos()

exports.RandomMovementBehavior = RandomMovementBehavior
