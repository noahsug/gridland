MovementBehavior = require('../coffee/movement_behavior.coffee').MovementBehavior
RandomMovementBehavior = require('../coffee/random_movement_behavior.coffee').RandomMovementBehavior
Position = require('../coffee/position.coffee').Position
util = require('../coffee/util.coffee').util

class SeekMovementBehavior extends MovementBehavior

  constructor: ->
    @targetDistance_ = undefined
    @target_ = undefined
    @randomMovement = new RandomMovementBehavior()

  setEntity: (entity) ->
    super entity
    @randomMovement.setEntity entity

  setKnowledge: (knowledge) ->
    super knowledge
    @randomMovement.setKnowledge knowledge

  setTargetTypes: (@targetTypes_...) ->

  getDestination_: ->
    @findClosestTarget_()
    if @target_ is 'none'
      return @moveRandomly_()
    destination = @seekTarget_()
    if @isValidPosition_ destination
      destination
    else
      @moveRandomly_()

  seekTarget_: ->
    possibleDestinations = []
    if @target_.getPos().x isnt @entity_.getPos().x
      destination = @moveHorizontally_()
      possibleDestinations.push destination if @isValidPosition_ destination
    if @target_.getPos().y isnt @entity_.getPos().y
      destination = @moveVertically_()
      possibleDestinations.push destination if @isValidPosition_ destination
    if possibleDestinations.length > 0
      return util.randElement possibleDestinations
    return Position.INVALID_POSITION

  moveHorizontally_: ->
    if @target_.getPos().x < @entity_.getPos().x
      x: @entity_.getPos().x - 1, y: @entity_.getPos().y
    else
      x: @entity_.getPos().x + 1, y: @entity_.getPos().y

  moveVertically_: ->
    if @target_.getPos().y < @entity_.getPos().y
      x: @entity_.getPos().x, y: @entity_.getPos().y - 1
    else
      x: @entity_.getPos().x, y: @entity_.getPos().y + 1

  moveRandomly_: ->
    @randomMovement.getAction().getDestination()

  findClosestTarget_: ->
    @targetDistance_ = Infinity
    @target_ = 'none'
    for target in @knowledge_.entities
      continue unless target.getType() in @targetTypes_
      distance = Position.distanceSquared target.getPos(), @entity_.getPos()
      if distance < @targetDistance_
        @target_ = target
        @targetDistance_ = distance

exports.SeekMovementBehavior = SeekMovementBehavior
