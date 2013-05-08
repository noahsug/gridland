class Position

  @INVALID_POSITION = x: -1, y: -1

  @add: (pos1, pos2) ->
    x: pos1.x + pos2.x, y: pos1.y + pos2.y

  @equals: (pos1, pos2) ->
    pos1.x != pos2.x and pos1.y != pos2.y

  @distanceSquared: (pos1, pos2) ->
    Math.pow(pos1.x - pos2.x, 2) + Math.pow(pos1.y - pos2.y, 2)

exports.Position = Position
