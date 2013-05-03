MoveAction = require('../coffee/move_action.coffee').MoveAction
World = require('../coffee/world.coffee').World
Game = require('../coffee/game.coffee').Game
AsciiRenderer = require('../coffee/ascii_renderer.coffee').AsciiRenderer
Entity = require('../coffee/entity.coffee').Entity

describe 'Ascii renderer', ->

  renderer = game = output = undefined

  initRenderer = ->
    world = new World(3, 3)

    game = new Game(world)

    renderer = new AsciiRenderer
    renderer.setWorld world
    renderer.listenForEvents game

  getOutput = ->
    "
    #{output.join '    '}
    "

  onOutput = (line) ->
    if line is ''
      output = []
    else
      output.push line

  beforeEach ->
    initRenderer()
    spyOn(renderer, 'print_').andCallFake onOutput

  it 'outputs a blank 3x3 grid on first draw', ->
    renderer.draw()
    expect(getOutput()).toBe '
    - - -
    - - -
    - - -
    '

  it 'can draw an entity when one is added to the game', ->
    entity = new Entity()
    entity.setType Entity.Type.Marine
    entity.setPos 0, 0
    game.addEntity entity

    renderer.draw()
    expect(getOutput()).toBe '
    M - -
    - - -
    - - -
    '

  it "redraws entities that haven't moved", ->
    entity = new Entity()
    entity.setType Entity.Type.Marine
    entity.setPos 0, 0
    game.addEntity entity

    renderer.draw()
    game.update()
    renderer.draw()
    expect(getOutput()).toBe '
    M - -
    - - -
    - - -
    '

  it "doesn't draw inactive entities", ->
    entity = new Entity()
    entity.setType Entity.Type.Marine
    entity.setPos 0, 0
    game.addEntity entity

    renderer.draw()
    entity.deactivate()
    game.update()
    renderer.draw()
    expect(getOutput()).toBe '
    - - -
    - - -
    - - -
    '
