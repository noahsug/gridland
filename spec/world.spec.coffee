World = require('../coffee/world.coffee').World
Entity = require('../coffee/entity.coffee').Entity

describe "A World", ->
  world = undefined

  beforeEach ->
    world = new World 10, 10

  it "has a width and height", ->
    world = new World 5, 40
    expect(world.getWidth()).toBe 5
    expect(world.getHeight()).toBe 40

  it "is initially empty", ->
    for x in [0..world.getWidth() - 1]
      for y in [0..world.getHeight() - 1]
        expect(world.isEmpty {x, y}).toBe true

  it "can get/set position values", ->
    expect(world.isEmpty x: 9, y: 3).toBe true
    world.set({x: 9, y: 3}, 1)
    expect(world.get x: 9, y: 3).toBe 1

  it "can add an entity", ->
    entity = new Entity()
    entity.setPos 0, 5
    world.add entity
    expect(world.get x: 0, y: 5).toBe entity

  it "can remove an entity", ->
    entity = new Entity()
    entity.setPos 0, 5
    world.add entity
    world.remove entity
    expect(world.isEmpty x: 0, y: 5).toBe true

  it "doesn't remove an entity when another entity has taken its spot", ->
    entity = new Entity()
    entity.setPos 0, 5
    world.add entity

    newEntity = new Entity()
    newEntity.setPos 0, 5
    world.add newEntity

    world.remove entity
    expect(world.get x: 0, y: 5).toBe newEntity
