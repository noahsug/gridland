Action = require('../coffee/action.coffee').Action

class Behavior
  constructor: ->

  setKnowledge: (@knowledge_) ->

  getAction: ->
    new Action

exports.Behavior = Behavior
