class Ray
  constructor: (@point, vector) ->
    @vector = vector.nor()

  getPoint: (distance) -> @point.add(@vector.mul(distance))

  getDistance: (point) -> (point.x - @point.x) / @vector.x

  computeIntersectionWithRay: (ray) ->
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

  computeIntersectionWithHorizontalLine: (line) ->
    d = (line.point1.x - @point.x) / @vector.x
    return null if (d < 0)
    p = @getPoint d
    if ((line.point1.y < p.y < line.point2.y) or (line.point2.y < p.y < line.point1.y))
      p
    else
      null

  computeIntersectionWithVerticalLine: (line) ->
    d = (line.point1.y - @point.y) / @vector.y
    return null if (d < 0)
    p = @getPoint (line.point1.y - @point.y) / @vector.y
    if ((line.point1.x < p.x < line.point2.x) or (line.point2.x < p.x < line.point1.x))
      p
    else
      null

  computeIntersectionWithLine: (line) ->
    if (line.point1.x == line.point2.x)
      @computeIntersectionWithHorizontalLine(line)
    else if (line.point1.y == line.point2.y)
      @computeIntersectionWithVerticalLine(line)
    else
      throw 'Doesnt work'
      ray = new Ray(line.point1, line.point1.sub(line.point2).nor())
      point = @computeIntersectionWithRay(ray)
      if !point || line.point1.dis(point) > line.length()
        null
      else
        point

# Export
window.Ray = Ray
