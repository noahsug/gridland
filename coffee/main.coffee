class Main

  @UPDATE_TIME = .75 # in seconds

  constructor: ->
    @elapsed_ = 0
    @updateCount_ = 0
    @init_()

  init_: ->
    @world_ = new World 27, 18
    @game_ = new Game @world_
    canvas = new Canvas()

    renderer = new HTML5Renderer canvas, @game_
    renderer.beginRendering()

    player = new Player renderer.getInput()
    player.play @game_

    canvas.on 'update', (dt) => @update_ dt
    @addEntity_()
    @addEntity_()

  update_: (dt) ->
    @elapsed_ += dt
    if @elapsed_ >= Main.UPDATE_TIME
      @updateCount_++
      if @shouldSpawnEntity_()
        @addEntity_()
      @elapsed_ -= Main.UPDATE_TIME
      @game_.update()

  shouldSpawnEntity_: ->
    return false if @getEnemyCount_() <= 0
    return @updateCount_ % 4 is 1 or @updateCount_ > 50

  getEnemyCount_: ->
    count = 0
    for entity in @game_.getEntities()
      count++ if entity.getType() is Entity.Type.Wolf
    return count

  addEntity_: ->
    entity = new Entity
    behavior = new MoveAndAttackBehavior()
    behavior.setMoveBehavior new SeekMovementBehavior()
    behavior.setAttackAccuracy .5
    behavior.setTargetTypes Entity.Type.Marine
    entity.setBehavior behavior
    entity.setPos @getRandomPosition_()
    entity.setType Entity.Type.Wolf
    @game_.addEntity entity

  getRandomPosition_: (count=0) ->
    pos = {
      x: util.randInt(@world_.getWidth() - 1),
      y: util.randInt(@world_.getHeight() - 1)
    }
    return pos if @world_.isEmpty(pos) or count > 5
    @getRandomPosition_ count + 1

main = new Main()
