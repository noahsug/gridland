class HTML5Renderer extends Renderer

  @GRID_LINE_WIDTH = 2

  constructor: (canvas, world) ->
    super world
    @initCanvas_ canvas
    @calculateGridSizeAndPos_()

  initCanvas_: (@canvas_) ->
    @canvas_.on 'update', (dt) => @animate_ dt
    @canvas_.on 'draw', => @draw_()
    @canvas_.on 'resize', => @calculateGridSizeAndPos_()
    @initInput_()

  initInput_: ->
    @input_ = new ComputerInput @canvas_

  getInput: ->
    @input_

  calculateGridSizeAndPos_: ->
    @calculateGridSize_()
    @calculateGridPos_()

  calculateGridSize_: ->
    idealBlockWidth = @canvas_.getWidth() / @world_.getWidth()
    idealBlockHeight = @canvas_.getHeight() / @world_.getHeight()
    @blockSize_ = Math.min idealBlockWidth, idealBlockHeight
    @input_.setBlockSize @blockSize_

  calculateGridPos_: ->
    @gridX_ = ( @canvas_.getWidth() -
        @blockSize_ * @world_.getWidth() ) / 2
    @gridY_ = ( @canvas_.getHeight() -
        @blockSize_ * @world_.getHeight() ) / 2
    @input_.setGridPos x: @gridX_, y: @gridY_

  beginRendering: ->
    @canvas_.startRendering()

  draw_: ->
    @drawBackground_()
    @drawEntities_()

  drawBackground_: ->
    @canvas_.getContext().fillStyle = '#202020'
    @canvas_.getContext().fillRect 0, 0,
        @canvas_.getWidth(), @canvas_.getHeight()

  drawEntities_: ->
    for col in [0..@world_.getWidth() - 1]
      for row in [0..@world_.getHeight() - 1]
        pos = { x: col, y: row }
        entity = @world_.get pos
        @drawEntity_ entity, pos

  drawEntity_: (entity, pos) ->
    color = @getEntityColor_ entity.getType()
    @drawGridSquare_ pos, color

  drawGridSquare_: (pos, color) ->
    x = @gridX_ + pos.x * @blockSize_ + HTML5Renderer.GRID_LINE_WIDTH / 2
    y = @gridY_ + pos.y * @blockSize_ + HTML5Renderer.GRID_LINE_WIDTH / 2
    size = @blockSize_ - HTML5Renderer.GRID_LINE_WIDTH
    @canvas_.getContext().fillStyle = color
    @canvas_.getContext().fillRect x, y, size, size

  getEntityColor_: (type) ->
    switch type
      when Entity.Type.Wolf then 'darkred'
      when Entity.Type.Marine then 'darkblue'
      when Entity.Type.Empty then '#404040'
      else 'white'

  animate_: (dt) ->
    # TODO: animate

  onWorldUpdated_: (actions) ->
    # TODO: animate actions

exports.HTML5Renderer = HTML5Renderer
