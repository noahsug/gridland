Action = require('../coffee/action.coffee').Action

class AttackAction extends Action
  constructor: ->
    super
    @accuracy_ = 1

  setTarget: (@target_) ->

  setAccuracy: (@accuracy_) ->

  actOn: (world) ->
    if Math.random() < @accuracy_
      world.remove @target_
      @target_.deactivate()

exports.AttackAction = AttackAction
