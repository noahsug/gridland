Position = require('../coffee/position.coffee').Position

describe 'Positions', ->

  it 'can be added', ->
    result = Position.add { x: 1, y: 3 }, { x: -1, y: 2 }
    expect(result).toEqual x: 0, y: 5
