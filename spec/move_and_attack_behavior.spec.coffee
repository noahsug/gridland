World = require('../coffee/world.coffee').World
Entity = require('../coffee/entity.coffee').Entity
Knowledge = require('../coffee/knowledge.coffee').Knowledge
MoveAndAttackBehavior = require('../coffee/move_and_attack_behavior.coffee').MoveAndAttackBehavior
RandomMovementBehavior = require('../coffee/random_movement_behavior.coffee').RandomMovementBehavior

describe 'Move and attack behavior', ->
  behavior = origPos = entity = world = undefined

  beforeEach ->
    world = new World 3, 3
    knowledge = new Knowledge world

    behavior = new MoveAndAttackBehavior()
    behavior.setMoveBehavior new RandomMovementBehavior()
    behavior.setTargetTypes Entity.Type.Wolf
    behavior.setKnowledge knowledge

    entity = new Entity()
    origPos = x: 1, y: 1
    entity.setPos origPos
    behavior.setEntity entity

  addEnemy = (x, y) ->
    enemy = new Entity()
    enemy.setPos { x, y }
    enemy.setType Entity.Type.Wolf
    world.add enemy
    return enemy

  it 'moves when no entities are near', ->
    addEnemy 0, 0
    behavior.getAction().actOn world
    expect(entity.getPos()).not.toEqual origPos

  it "doesn't move when entities are near", ->
    addEnemy 1, 0
    behavior.getAction().actOn world
    expect(entity.getPos()).toEqual origPos

  it 'attacks when an entity is nearby', ->
    addEnemy 1, 0
    expect(world.isEmpty(x: 1, y: 0)).toBe false
    behavior.getAction().actOn world
    expect(world.isEmpty(x: 1, y: 0)).toBe true

  it 'attacks only one nearby entity', ->
    enemies = [
      addEnemy 1, 0
      addEnemy 0, 1
      addEnemy 1, 2
      addEnemy 2, 1
    ]
    behavior.getAction().actOn world
    inactive = (enemy for enemy in enemies when not enemy.isActive())
    expect(inactive.length).toBe 1
