Action = require('../coffee/action.coffee').Action
Behavior = require('../coffee/behavior.coffee').Behavior

class Entity

  @Type =
    Empty: 0,
    Marine: 1,
    Wolf: 2

  constructor: ->
    @behavior_ = new Behavior
    @pos_ = {x: -1, y: -1}
    @active_ = true
    @type_ = Entity.Type.Empty
    @cost_ = 0

  getCost: ->
    @cost_

  setCost: (@cost_) ->

  setType: (@type_) ->

  getType: ->
    @type_

  setBehavior: (@behavior_) ->
    @behavior_.setEntity this

  setPos: (pos) ->
    @pos_.x = pos.x
    @pos_.y = pos.y

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
