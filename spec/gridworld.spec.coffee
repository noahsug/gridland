MoveAction = require('../coffee/move_action.coffee').MoveAction
World = require('../coffee/world.coffee').World
Game = require('../coffee/game.coffee').Game
ConsoleRenderer = require('../coffee/console_renderer.coffee').ConsoleRenderer
Entity = require('../coffee/entity.coffee').Entity
Player = require('../coffee/player.coffee').Player
Input = require('../coffee/input.coffee').Input

describe 'Gridworld', ->
  renderer = input = game = output = entity = undefined

  init = ->
    world = new World 3, 3
    game = new Game world
    renderer = new ConsoleRenderer game

    input = new Input
    player = new Player input
    player.play game

  click = (x, y) ->
    input.addEntity_ { x, y }

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
    init()
    spyOn(renderer, 'print_').andCallFake onOutput
    renderer.beginRendering()

  addEntity = ->
    entity = new Entity()
    entity.setType Entity.Type.Wolf
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
    W - -
    - - -
    - - -
    '

  it "redraws entities that haven't moved", ->
    addEntity()
    game.update()
    game.update()
    expect(getOutput()).toBe '
    W - -
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

  it "adds an entity through input", ->
    click 0, 0
    renderer.draw()
    expect(getOutput()).toBe '
    M - -
    - - -
    - - -
    '

  it "can add multiple entities through input", ->
    for x in [0..2]
      for y in [0..2]
        click x, y
    renderer.draw()
    expect(getOutput()).toBe '
    M M M
    M M M
    M M M
    '

  it "doesn't add an entity through input when the pos is taken", ->
    addEntity()
    click 0, 0
    renderer.draw()
    expect(getOutput()).toBe '
    W - -
    - - -
    - - -
    '
