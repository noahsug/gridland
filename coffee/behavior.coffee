Action = require('../coffee/action.coffee').Action

class Behavior

  setEntity: (@entity_) ->

  setKnowledge: (@knowledge_) ->

  getAction: ->
    new Action

exports.Behavior = Behavior
