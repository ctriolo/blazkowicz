class LineSegment
  constructor: (@point1, @point2) ->
  length: () -> @point1.dis(@point2)

# Export
window.LineSegment = LineSegment
