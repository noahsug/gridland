Action = require('../coffee/action.coffee').Action

class Behavior
  constructor: ->

  setEntity: (@entity_) ->

  setKnowledge: (@knowledge_) ->

  getAction: ->
    new Action

exports.Behavior = Behavior
