Main = require('../coffee/main.coffee').Main

describe 'Gridworld', ->
  gridworld = undefined

  beforeEach ->
    gridworld = new Main()

  it 'can run', ->
    gridworld.run()
