util = require('../coffee/util.coffee').util
Knowledge = require('../coffee/knowledge.coffee').Knowledge
EventEmitter = require('../coffee/event_emitter.coffee').EventEmitter

class Game extends EventEmitter
  constructor: (@world_) ->
    super
    @entities_ = []
    @entityKnowledge_ = new Knowledge @world_, @entities_
    @money_ = 0
    @income_ = .5

  setMoney: (@money_) ->

  getMoney: ->
    Math.floor @money_

  setIncome: (@income_) ->

  getWorld: ->
    @world_

  canAddEntityAt: (pos, cost) ->
    return false if @money_ < cost
    return @world_.isInWorld(pos) and @world_.isEmpty(pos)

  addEntity: (entity) ->
    @money_ -= entity.getCost()
    @entities_.push entity
    entity.setKnowledge(@entityKnowledge_)
    @world_.add entity

  update: ->
    @performEntityActions_()
    @removeInactiveEntities_()
    @money_ += @income_
    @emit 'world_updated', @actions_

  performEntityActions_: ->
    @actions_ = (entity.getAction() for entity in @entities_)
    for action in util.shuffle @actions_
      action.actOn @world_

  removeInactiveEntities_: ->
    for entity in @entities_ when not entity.isActive()
      @world_.remove entity
    @entities_ = (entity for entity in @entities_ when entity.isActive())
    @entityKnowledge_.updateEntities @entities_

exports.Game = Game
