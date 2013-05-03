Game = require('../coffee/game.coffee').Game
World = require('../coffee/world.coffee').World
Entity = require('../coffee/entity.coffee').Entity

describe "A Game", ->
  game = undefined

  beforeEach ->
    game = new Game(new World 10, 10)

  it "allows entities to act on a world", ->
    entity = new Entity()
    game.addEntity entity

    spyOn(entity, 'getAction').andCallThrough()
    game.update()
    expect(entity.getAction).toHaveBeenCalled()

  it "doesn't allow inactive entities to act on the world'", ->
    entity = new Entity()
    game.addEntity entity

    entity.isActive = -> false
    game.update()

    spyOn(entity, 'getAction').andCallThrough()
    game.update()
    expect(entity.getAction).not.toHaveBeenCalled()
