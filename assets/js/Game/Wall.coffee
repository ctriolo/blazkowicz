#= require_tree ../Math
#= require ./Entity.js

class Wall extends Entity

  constructor: (@_line) ->
    throw 'Need a line' if not @_line

  @constructFromPoints: (type, point1, point2) ->
    new type new LineSegment(point1, point2)

  @constructFromValues: (type, x1, y1, x2, y2) ->
    @constructFromPoints type, new Vector(x1,y1), new Vector(x2,y2)

  line: -> @_line
  computeCollision: (ray) -> @computeIntersection ray

  # remove these
  spriteSheet: -> 
    sheet = new Image()
    sheet.src = '/img/walls.png'
    sheet
  spriteDimensions: -> [64, 64]

# Export
window.Wall = Wall
