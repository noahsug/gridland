Input = require('../coffee/input.coffee').Input

class ComputerInput extends Input
  constructor: (@canvas_) ->
    super
    @canvas_.on 'update', => @checkInput_()
    @canvas_.input.bind @canvas_.button.LEFT, 'mouse'

  setGridPos: (@gridPos_) ->

  setBlockSize: (@blockSize_) ->

  checkInput_: ->
    if @canvas_.input.pressed 'mouse'
      col = Math.floor((@canvas_.input.mouse.x - @gridPos_.x) / @blockSize_)
      row = Math.floor((@canvas_.input.mouse.y - @gridPos_.y) / @blockSize_)
      @addEntity_ x: col, y: row

exports.ComputerInput = ComputerInput
