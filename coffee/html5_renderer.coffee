class HTML5Renderer extends Renderer

  @GRID_LINE_WIDTH = .05
  @MONEY_SIZE = .35
  @MONEY_BUFFER = .1
  @MONEY_PADDING = .1
  @MONEY_UI_HEIGHT = @MONEY_SIZE + @MONEY_BUFFER * 2

  constructor: (canvas, game) ->
    super game
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
    @gridLineWidth_ = @blockSize_ * HTML5Renderer.GRID_LINE_WIDTH
    @moneySize_ = @blockSize_ * HTML5Renderer.MONEY_SIZE
    @moneyBuffer_ = @blockSize_ * HTML5Renderer.MONEY_BUFFER
    @moneyUIHeight_ = @blockSize_ * HTML5Renderer.MONEY_UI_HEIGHT
    @moneyPadding_ = @blockSize_ * HTML5Renderer.MONEY_PADDING
    @calculateGridPos_()

  calculateGridSize_: ->
    idealBlockWidth = @canvas_.getWidth() / @world_.getWidth()
    idealBlockHeight = @canvas_.getHeight() /
        (@world_.getHeight() + HTML5Renderer.MONEY_UI_HEIGHT)
    @blockSize_ = Math.min idealBlockWidth, idealBlockHeight
    @gridWidth_ = @blockSize_ * @world_.getWidth()
    @gridHeight_ = @blockSize_ * @world_.getHeight()
    @input_.setBlockSize @blockSize_

  calculateGridPos_: ->
    @gridX_ = ( @canvas_.getWidth() - @gridWidth_ ) / 2
    @gridY_ = ( @canvas_.getHeight() - @gridHeight_ + @moneyUIHeight_ ) / 2
    @input_.setGridPos x: @gridX_, y: @gridY_

  beginRendering: ->
    @canvas_.startRendering()

  draw_: ->
    @drawBackground_()
    @drawEntities_()
    @drawMoney_()

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
    x = @gridX_ + pos.x * @blockSize_ + @gridLineWidth_ / 2
    y = @gridY_ + pos.y * @blockSize_ + @gridLineWidth_ / 2
    size = @blockSize_ - @gridLineWidth_
    @canvas_.getContext().fillStyle = color
    @canvas_.getContext().fillRect x, y, size, size

  getEntityColor_: (type) ->
    switch type
      when Entity.Type.Wolf then 'darkred'
      when Entity.Type.Marine then 'darkblue'
      when Entity.Type.Empty then '#404040'
      else 'white'

  drawMoney_: ->
    return if @game_.getMoney() <= 0
    y = @moneyBuffer_
    for i in [0..@game_.getMoney() - 1]
      x = @gridX_ + i * (@moneySize_ + @moneyPadding_)
      return if x + @moneySize_ > @gridX_ + @gridWidth_
      @canvas_.getContext().fillStyle = '#404040'
      @canvas_.getContext().fillRect x, y, @moneySize_, @moneySize_

  animate_: (dt) ->
    # TODO: animate

  onWorldUpdated_: (actions) ->
    # TODO: animate actions

exports.HTML5Renderer = HTML5Renderer
