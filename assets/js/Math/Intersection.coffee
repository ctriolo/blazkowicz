class Intersection
  constructor: (@ray, @distance, @object) ->
  attach: (@object) ->
  point: -> @ray.getPoint @distance

window.Intersection = Intersection
