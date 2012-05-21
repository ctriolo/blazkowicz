#= require_tree ../Math
#= require Entity

# Default Sprite Sheet and Dimensions
SPRITE_SHEET = new Image()
SPRITE_SHEET.src = '/img/walls.png'
SPRITE_DIMENSIONS = [64, 64]

class Wall extends Entity

  constructor: (@_line) ->
    throw 'Need a line' if not @_line

  @constructFromPoints: (type, point1, point2) ->
    new type new LineSegment(point1, point2)

  @constructFromValues: (type, x1, y1, x2, y2) ->
    @constructFromPoints type, new Vector(x1,y1), new Vector(x2,y2)

  line: -> @_line
  computeCollision: (ray) -> @computeIntersection ray

  spriteSheet: -> SPRITE_SHEET
  spriteDimensions: -> SPRITE_DIMENSIONS

# Export
window.Wall = Wall
