util = require('../coffee/util.coffee').util

describe 'Util functions:', ->

  describe 'shuffle', ->
    it 'randomizes the order of an array in place', ->
      shuffled = [0..19]
      util.shuffle shuffled
      diff = (ele for ele, i in shuffled when ele isnt i)
      expect(diff.length).toBeGreaterThan 0

    it 'keeps the elements of the original array', ->
      original = [1, 2, 3, 4, 5, 'c', 'e', 'f']
      shuffled = util.shuffle original[..]
      expect(shuffled.length).toBe original.length
      for i in original
        expect(shuffled).toContain i

    it 'does nothing to an array of size < 2', ->
      arr = util.shuffle [1]
      expect(arr).toEqual [1]

      arr = util.shuffle []
      expect(arr).toEqual []

  describe 'randInt', ->
    it 'returns an int in range [min, max]', ->
      min = 13
      max = 17
      for i in [1..20]
        expect(min <= util.randInt(min, max) <= max).toBe true

    it 'returned int is inclusive of the min and max', ->
      min = 9
      max = 12
      wasMin = wasMax = false
      for i in [1..40]
        result = util.randInt(min, max)
        wasMin or= result is min
        wasMax or= result is max
      expect(wasMin and wasMax).toBe true

    it 'defaults min to 0', ->
      max = 8
      for i in [1..20]
        expect(0 <= util.randInt(max) <= max).toBe true
