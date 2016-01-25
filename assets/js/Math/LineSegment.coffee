#= require ./Intersection.js

class LineSegment
  constructor: (@point1, @point2) ->
  length: -> @point1.dis(@point2)
  points: -> [@point1, @point2]

  computeIntersection: (ray) ->
    [p1, p2] = @points()
    [p, v] = [ray.point, ray.vector]
    d1 = p1.sub p
    d2 = p2.sub p1

    hn = (v.y * d1.x - v.x * d1.y)
    hd = (v.x * d2.y - v.y * d2.x)
    h = hn / hd
    return if h < 0 or h > 1

    point = p1.add (p2.sub p1).mul h
    distance = ray.distance point
    return if distance < 0

    new Intersection ray, distance

# Export
window.LineSegment = LineSegment
