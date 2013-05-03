class Util

  shuffle: (arr) ->
    return arr if arr.length < 2
    for i in [0..arr.length - 2]
      swapIndex = @randInt i, arr.length - 1
      @swap arr, i, swapIndex
    return arr

  swap: (arr, index1, index2) ->
    [arr[index2], arr[index1]] = [arr[index1], arr[index2]]

  # Return an integer in the range [min, max]
  randInt: (min=0, max) ->
    throw "min must be <= max, but #{min} > #{max}" if min > max
    Math.floor(Math.random() * (max + 1 - min) + min)

exports.util = new Util