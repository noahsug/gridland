Entity = require('../coffee/entity.coffee').Entity
RandomMovementBehavior = require?('../coffee/random_movement_behavior.coffee').RandomMovementBehavior

class Player
  constructor: (input) ->
    input.on 'add_entity', (pos) => @addEntity_ pos

  play: (@game_) ->

  addEntity_: (pos) ->
    return unless @game_.canAddEntityAt pos
    entity = new Entity()
    entity.setPos pos
    entity.setType Entity.Type.Marine
    entity.setBehavior new RandomMovementBehavior()
    @game_.addEntity entity

exports.Player = Player
