MoveAction = require('../coffee/move_action.coffee').MoveAction
World = require('../coffee/world.coffee').World
Entity = require('../coffee/entity.coffee').Entity

describe 'A move action', ->

  moveAction = world = entity = undefined

  beforeEach ->
    world = new World(10, 10)
    entity = new Entity()
    entity.setType Entity.Type.Marine
    entity.setPos x: 2, y: 5
    moveAction = new MoveAction()

  it 'moves an entity to a new position', ->
    moveAction.setSource entity
    moveAction.setDestination x: 2, y: 6
    moveAction.actOn world

    expect(entity.getPos()).toEqual x: 2, y: 6

  it 'updates the world after an entity moves', ->
    moveAction.setSource entity
    moveAction.setDestination x: 2, y: 6
    moveAction.actOn world

    expect(world.get(x: 2, y: 5).getType()).toBe Entity.Type.Empty
    expect(world.get(x: 2, y: 6).getType()).toBe Entity.Type.Marine
