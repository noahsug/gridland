class Main

  @UPDATE_TIME = 1 # in seconds

  constructor: ->
    @elapsed_ = 0
    @updateCount_ = 0
    @init_()

  init_: ->
    @world_ = new World 9, 9
    @game_ = new Game @world_
    canvas = new Canvas()

    renderer = new HTML5Renderer canvas, @world_
    renderer.listenToGameEvents @game_
    renderer.beginRendering()

    player = new Player renderer.getInput()
    player.play @game_

    canvas.on 'update', (dt) => @update_ dt

  update_: (dt) ->
    @elapsed_ += dt
    if @elapsed_ >= Main.UPDATE_TIME
      @updateCount_++
      if @updateCount_ < 10 and @updateCount_ % 2 is 1
        @addEntity_()
      @elapsed_ -= Main.UPDATE_TIME
      @game_.update()

  addEntity_: ->
    entity = new Entity
    entity.setBehavior new RandomMovementBehavior()
    entity.setPos @getRandomPosition_()
    entity.setType Entity.Type.Wolf
    @game_.addEntity entity

  getRandomPosition_: ->
    {
      x: util.randInt(@world_.getWidth() - 1),
      y: util.randInt(@world_.getHeight() - 1)
    }

main = new Main()
