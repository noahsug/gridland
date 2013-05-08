Behavior = require('../coffee/behavior.coffee').Behavior
AttackAction = require('../coffee/attack_action.coffee').AttackAction
util = require('../coffee/util.coffee').util

class MoveAndAttackBehavior extends Behavior
  constructor: ->
    super
    @attackAccuracy_ = 1

  setTargetTypes: (@targetTypes_...) ->
    @moveBehavior_?.setTargetTypes? @targetTypes_...

  setKnowledge: (knowledge) ->
    super knowledge
    @moveBehavior_?.setKnowledge knowledge

  setEntity: (entity) ->
    super entity
    @moveBehavior_?.setEntity entity

  setAttackAccuracy: (@attackAccuracy_) ->

  setMoveBehavior: (@moveBehavior_) ->

  getAction: ->
    target = @getTargetInRange_()
    if target isnt 'none'
      action = new AttackAction()
      action.setAccuracy @attackAccuracy_
      action.setTarget target
      return action
    @moveBehavior_.getAction()

  getTargetInRange_: ->
    for entity in util.shuffle @getNeighboringEntities_()
      if entity.getType() in @targetTypes_
        return entity
    return 'none'

  getNeighboringEntities_: ->
    for pos in @getNeighborhood_() when @knowledge_.world.contains pos
      @knowledge_.world.get pos

  getNeighborhood_: ->
    center = @entity_.getPos()
    [
      { x: center.x - 1, y: center.y }
      { x: center.x + 1, y: center.y }
      { x: center.x, y: center.y + 1 }
      { x: center.x, y: center.y - 1 }
    ]

exports.MoveAndAttackBehavior = MoveAndAttackBehavior
