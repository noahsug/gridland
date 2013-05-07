EventEmitter = require('../coffee/event_emitter.coffee').EventEmitter

class Input extends EventEmitter

  addEntity_: (pos) ->
    @emit 'add_entity', pos

exports.Input = Input
