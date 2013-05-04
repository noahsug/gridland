Renderer = require('../coffee/renderer.coffee').Renderer
Entity = require('../coffee/entity.coffee').Entity

class AsciiRenderer extends Renderer

  renderWorld_: ->
    @draw_()

  beginRendering: ->
    @draw_()

  draw_: ->
    @print_ ''
    for y in [0..@world_.getHeight() - 1]
      row = []
      for x in [0..@world_.getWidth() - 1]
        row.push @drawEntity_ @world_.get {x, y}
      @print_ row.join ' '

  print_: (str) ->
    console.log str

  drawEntity_: (entity) ->
    switch entity.getType()
      when Entity.Type.Marine then 'M'
      else '-'

exports.AsciiRenderer = AsciiRenderer
