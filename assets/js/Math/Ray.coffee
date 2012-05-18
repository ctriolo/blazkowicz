class Ray
  constructor: (@point, vector) ->
    @vector = vector.nor()

  getPoint: (distance) -> @point.add(@vector.mul(distance))

  getDistance: (point) -> (point.x - @point.x) / @vector.x
  distance: (point) -> (point.x - @point.x) / @vector.x

# Export
window.Ray = Ray
