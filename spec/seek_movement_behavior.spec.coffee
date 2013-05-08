World = require('../coffee/world.coffee').World
Entity = require('../coffee/entity.coffee').Entity
Knowledge = require('../coffee/knowledge.coffee').Knowledge
SeekMovementBehavior = require('../coffee/seek_movement_behavior.coffee').SeekMovementBehavior

describe 'Seeking movement behavior', ->
  behavior = knowledge = entity = world = undefined

  beforeEach ->
    world = new World 4, 4
    knowledge = new Knowledge world

    behavior = new SeekMovementBehavior()
    behavior.setTargetTypes Entity.Type.Wolf
    behavior.setKnowledge knowledge

    entity = new Entity()
    behavior.setEntity entity
    knowledge.entities = [entity]

  addEnemy = (x, y) ->
    enemy = new Entity()
    enemy.setPos { x, y }
    enemy.setType Entity.Type.Wolf
    world.add enemy
    knowledge.entities.push enemy
    return enemy

  addFriendly = (x, y) ->
    friendly = addEnemy(x, y)
    friendly.setType Entity.Type.Marine
    return friendly

  it 'moves randomly when there are no enemies to seek', ->
    origPos = x: 2, y: 3
    entity.setPos origPos
    behavior.getAction().actOn world

    pos = entity.getPos()
    distance = Math.abs(pos.x - origPos.x) + Math.abs(pos.y - origPos.y)
    expect(distance).toBe 1

  it 'moves towards an enemy', ->
    entity.setPos x: 2, y: 2
    addEnemy 0, 2
    behavior.getAction().actOn world
    expect(entity.getPos()).toEqual x: 1, y: 2

  it "moves randomly when target's path is blocked", ->
    origPos = x: 2, y: 2
    entity.setPos origPos
    addEnemy 0, 2
    addFriendly 1, 2
    behavior.getAction().actOn world

    pos = entity.getPos()
    distance = Math.abs(pos.x - origPos.x) + Math.abs(pos.y - origPos.y)
    expect(distance).toBe 1
    expect(pos).not.toEqual { x: 1, y: 2 }
