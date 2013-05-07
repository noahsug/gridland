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

  addEntity = (x, y) ->
    otherEntity = new Entity()
    otherEntity.setPos { x, y }
    otherEntity.setType Entity.Type.Marine
    world.add otherEntity

  it 'moves an entity to an adjacent position when able', ->
    origPos = x: 2, y: 3
    entity.setPos origPos
    behavior.getAction().actOn world
    pos = entity.getPos()
    distance = Math.abs(pos.x - origPos.x) + Math.abs(pos.y - origPos.y)
    expect(distance).toBe 1

  it "doesn't move an entity when its blocked in", ->
    entity.setPos x: 0, y: 0
    addEntity 0, 1
    addEntity 1, 0
    behavior.getAction().actOn world
    expect(entity.getPos()).toEqual x: 0, y: 0
