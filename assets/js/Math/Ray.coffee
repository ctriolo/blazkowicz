class Ray
  constructor: (@point, vector) ->
    @vector = vector.nor()

  getPoint: (distance) -> @point.add(@vector.mul(distance))

  getDistance: (point) -> (point.x - @point.x) / @vector.x

  computeIntersection: (ray) ->
    throw 'Doesnt work'
    div = @vector.x * ray.vector.x - @vector.y * ray.vector.y
    if (div == 0)
      null
    else
      distance = (ray.vector.x*(ray.point.y - @point.y) +
        ray.vector.y*(@point.x - ray.point.x)) / div
      if distance <= 0
        return null
      else
        return @getPoint distance

# Export
window.Ray = Ray
