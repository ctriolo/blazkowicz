#= require Intersection

class LineSegment
  constructor: (@point1, @point2) ->
  length: -> @point1.dis(@point2)
  points: -> [@point1, @point2]

  computeIntersection: (ray) ->
    if (@point1.x == @point2.x)
      @computeIntersectionWithHorizontalLine(ray)
    else if (@point1.y == @point2.y)
      @computeIntersectionWithVerticalLine(ray)
    else
      throw 'Doesnt work'

  computeIntersectionWithHorizontalLine: (ray) ->
    [p1, p2] = @points()
    d = (p1.x - ray.point.x) / ray.vector.x
    p = ray.getPoint d
    if d > 0 and (p1.y < p.y < p2.y or p2.y < p.y < p1.y)
      new Intersection ray, d

  computeIntersectionWithVerticalLine: (ray) ->
    [p1, p2] = @points()
    d = (p1.y - ray.point.y) / ray.vector.y
    p = ray.getPoint d
    if d > 0 and (p1.x < p.x < p2.x or p2.x < p.x < p1.x)
      new Intersection ray, d

# Export
window.LineSegment = LineSegment
