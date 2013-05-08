Entity = require('../coffee/entity.coffee').Entity
MoveAndAttackBehavior = require('../coffee/move_and_attack_behavior.coffee').MoveAndAttackBehavior
SeekMovementBehavior = require('../coffee/seek_movement_behavior.coffee').SeekMovementBehavior

class Player
  constructor: (input) ->
    input.on 'add_entity', (pos) => @addEntity_ pos

  play: (@game_) ->

  addEntity_: (pos) ->
    return unless @game_.canAddEntityAt pos, 1
    entity = new Entity()
    entity.setPos pos
    entity.setType Entity.Type.Marine
    behavior = new MoveAndAttackBehavior()
    behavior.setMoveBehavior new SeekMovementBehavior()
    behavior.setTargetTypes Entity.Type.Wolf
    entity.setBehavior behavior
    entity.setCost 1
    @game_.addEntity entity

exports.Player = Player
