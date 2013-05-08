AttackAction = require('../coffee/attack_action.coffee').AttackAction
World = require('../coffee/world.coffee').World
Entity = require('../coffee/entity.coffee').Entity

describe 'An attack action', ->

  attackAction = world = entity = entity2 = undefined

  beforeEach ->
    world = new World(10, 10)
    attackAction = new AttackAction()

    entity = new Entity()
    entity.setType Entity.Type.Marine
    entity.setPos x: 2, y: 5

    entity2 = new Entity()
    entity2.setType Entity.Type.Wolf
    entity2.setPos x: 2, y: 4

  it 'moves an entity to a new position', ->
    attackAction.setTarget entity2
    attackAction.actOn world

    expect(world.isEmpty entity2.getPos()).toBe true
    expect(entity2.isActive()).toBe false
