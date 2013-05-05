class Main extends atom.Game
  constructor: ->
    super
    @init_()
    @runGameLoop_()

  update: (dt) ->

  draw: ->
    @drawBackground_()
    @drawPlayer_()

  drawBackground_: ->
    atom.context.fillStyle = '#202020'
    atom.context.fillRect 0, 0, atom.width, atom.height

  drawPlayer_: ->
    atom.context.beginPath()
    atom.context.arc atom.width/2, atom.height/2, 15, 0, 2 * Math.PI, false
    atom.context.lineWidth = 5
    atom.context.strokeStyle = 'orange'
    atom.context.stroke()

  init_: ->
    @world_ = new World 3, 3
    @game_ = new Game @world_
    renderer = new AsciiRenderer @game_
    renderer.beginRendering()

  runGameLoop_: (count=1) ->
    setTimeout =>
      if count % 2 is 1
        entity = new Entity
        entity.setBehavior new RandomMovementBehavior()
        entity.setPos @getRandomPosition_()
        entity.setType Entity.Type.Marine
        @game_.addEntity entity
      @game_.update()
      if count < 6
        @runGameLoop_ count + 1
    , 1000

  getRandomPosition_: ->
    {
      x: util.randInt(@world_.getWidth() - 1),
      y: util.randInt(@world_.getHeight() - 1)
    }


main = new Main()
$('window').on 'blur', main.stop()
$('window').on 'focus', main.run()
main.run()
