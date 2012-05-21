#= require_tree ../Math
#= require Entity

class Wall extends Entity

  constructor: (@_line, @texture) ->
    throw 'Need a line and a texture' if not @line or not @texture

  @constructFromPoints: (point1, point2, texture) ->
    new Wall new LineSegment(point1, point2), texture

  @constructFromValues: (x1, y1, x2, y2, texture) ->
    @constructFromPoints new Vector(x1,y1), new Vector(x2,y2), texture

  line: -> @_line
  computeCollision: (ray) -> @computeIntersection ray

  spriteSheet: -> @texture
  spriteDimensions: -> [64,64]
  spriteOffsets: -> [0,0]

# Export
window.Wall = Wall
