class Canvas extends EventEmitter
  constructor: ->
    super
    @game_ = new atom.Game()
    $(window).on 'blur', => @game_.stop()
    $(window).on 'focus', => @game_.run()
    $(window).on 'resize', => @onResize_()
    @game_.draw = => @emit 'draw'
    @game_.update = (dt) => @emit 'update', dt
    @input = atom.input
    @button = atom.button
    @key = atom.key

  onResize_: ->
    if not @game_.running
      @emit 'draw'
    @emit 'resize'

  startRendering: ->
    @game_.run()

  getWidth: ->
    atom.width

  getHeight: ->
    atom.height

  getContext: ->
    atom.context

exports.Canvas = Canvas
