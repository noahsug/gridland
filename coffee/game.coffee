Knowledge = require('../coffee/knowledge.coffee').Knowledge
util = require('../coffee/util.coffee').util
EventEmitter = require('../coffee/event_emitter.coffee').EventEmitter

class Game extends EventEmitter
  constructor: (world) ->
    super
    @entities_ = []
    @entityKnowledge_ = new Knowledge
    @setWorld_ world

  setWorld_: (@world_) ->
    @entityKnowledge_.setWorld @world_

  getWorld: ->
    @world_

  addEntity: (entity) ->
    @entities_.push entity
    entity.setKnowledge(@entityKnowledge_)
    @world_.add entity
    @emit 'entity_added', entity

  update: ->
    @performEntityActions_()
    @removeInactiveEntities_()

  performEntityActions_: ->
    actions = (entity.getAction() for entity in @entities_)
    for action in util.shuffle actions
      action.actOn @world_
    @emit 'actions', actions

  removeInactiveEntities_: ->
    for entity in @entities_ when not entity.isActive()
      @world_.remove entity
      @emit 'entity_removed', entity
    @entities_ = (entity for entity in @entities_ when entity.isActive())
    @entityKnowledge_.setEntities @entities_

exports.Game = Game
