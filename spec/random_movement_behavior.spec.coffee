World = require?('../coffee/world.coffee').World
Entity = require?('../coffee/entity.coffee').Entity
Knowledge = require?('../coffee/knowledge.coffee').Knowledge
RandomMovementBehavior = require?('../coffee/random_movement_behavior.coffee').RandomMovementBehavior

describe 'Random movement behavior', ->
  behavior = entity = world = undefined

  beforeEach ->
    world = new World 4, 6
    knowledge = new Knowledge world

    behavior = new RandomMovementBehavior()
    behavior.setKnowledge knowledge

    entity = new Entity()
    behavior.setEntity entity

  it 'moves an entity to an adjacent position when able', ->
    origPos = x: 2, y: 3
    entity.setPos origPos
    behavior.getAction().actOn world
    pos = entity.getPos()
    distance = Math.abs(pos.x - origPos.x) + Math.abs(pos.y - origPos.y)
    expect(distance).toBe 1
