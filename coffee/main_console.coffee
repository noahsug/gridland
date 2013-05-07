# A version of gridworld that renders to console.log.

ConsoleRenderer = require('../coffee/console_renderer.coffee').ConsoleRenderer
Entity = require('../coffee/entity.coffee').Entity
Game = require('../coffee/game.coffee').Game
RandomMovementBehavior = require('../coffee/random_movement_behavior.coffee').RandomMovementBehavior
World = require('../coffee/world.coffee').World
util = require('../coffee/util.coffee').util

class Main
  run: ->
    @init_()
    @runGameLoop_()

  init_: ->
    @world_ = new World 3, 3
    @game_ = new Game @world_
    renderer = new ConsoleRenderer @game_
    renderer.beginRendering()

  runGameLoop_: (count=1) ->
    setTimeout =>
      if count % 2 is 1
        entity = new Entity
        entity.setBehavior new RandomMovementBehavior()
        entity.setPos @getRandomPosition_()
        entity.setType Entity.Type.Marine
        @game_.addEntity entity
      @game_.update()
      if count < 6
        @runGameLoop_ count + 1
    , 1000

  getRandomPosition_: ->
    {
      x: util.randInt(@world_.getWidth() - 1),
      y: util.randInt(@world_.getHeight() - 1)
    }

main = new Main()
main.run()
