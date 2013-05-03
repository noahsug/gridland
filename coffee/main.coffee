World = require('../coffee/world.coffee').World
Game = require('../coffee/game.coffee').Game
AsciiRenderer = require('../coffee/ascii_renderer.coffee').AsciiRenderer

class Main
  run: ->
    @init_()
    @runGameLoop_()

  init_: ->
    world = new World(3, 3)

    game = new Game(world)

    renderer = new AsciiRenderer
    renderer.setWorld world
    renderer.listenForEvents game
    renderer.draw()

  runGameLoop_: ->

exports.Main = Main
