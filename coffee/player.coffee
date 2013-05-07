Entity = require('../coffee/entity.coffee').Entity
RandomMovementBehavior = require?('../coffee/random_movement_behavior.coffee').RandomMovementBehavior

class Player
  constructor: (input) ->
    input.on 'add_entity', (pos) => @addEntity_ pos

  play: (@game_) ->

  addEntity_: (pos) ->
    return unless @game_.canAddEntityAt pos, 1
    entity = new Entity()
    entity.setPos pos
    entity.setType Entity.Type.Marine
    entity.setBehavior new RandomMovementBehavior()
    entity.setCost 1
    @game_.addEntity entity

exports.Player = Player
