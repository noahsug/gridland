MoveAction = require('../coffee/move_action.coffee').MoveAction
World = require('../coffee/world.coffee').World
Game = require('../coffee/game.coffee').Game
AsciiRenderer = require('../coffee/ascii_renderer.coffee').AsciiRenderer
Entity = require('../coffee/entity.coffee').Entity

describe 'Ascii renderer', ->

  renderer = game = output = entity = undefined

  initRenderer = ->
    world = new World(3, 3)
    game = new Game(world)
    renderer = new AsciiRenderer game

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
    renderer.beginRendering()

  addEntity = ->
    entity = new Entity()
    entity.setType Entity.Type.Marine
    entity.setPos x: 0, y: 0
    game.addEntity entity

  it 'outputs a blank 3x3 grid on first draw', ->
    expect(getOutput()).toBe '
    - - -
    - - -
    - - -
    '

  it 'can draw an entity when one is added to the game', ->
    addEntity()
    game.update()
    expect(getOutput()).toBe '
    M - -
    - - -
    - - -
    '

  it "redraws entities that haven't moved", ->
    addEntity()
    game.update()
    game.update()
    expect(getOutput()).toBe '
    M - -
    - - -
    - - -
    '

  it "doesn't draw inactive entities", ->
    addEntity()
    entity.deactivate()
    game.update()
    expect(getOutput()).toBe '
    - - -
    - - -
    - - -
    '
