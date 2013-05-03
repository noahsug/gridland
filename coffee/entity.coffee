Action = require('../coffee/action.coffee').Action
Behavior = require('../coffee/behavior.coffee').Behavior

class Entity

  @Type =
    Empty: 0,
    Marine: 1

  constructor: ->
    @behavior_ = new Behavior
    @pos_ = {x: -1, y: -1}
    @active_ = true
    @type_ = Entity.Type.Empty

  setType: (@type_) ->

  getType: ->
    @type_

  setBehavior: (@behavior_) ->

  setPos: (x, y) ->
    @pos_.x = x
    @pos_.y = y

  getPos: ->
    @pos_

  setKnowledge: (knowledge) ->
    @behavior_.setKnowledge knowledge

  getAction: ->
    @behavior_.getAction()

  deactivate: ->
    @active_ = false

  isActive: ->
    @active_

exports.Entity = Entity
