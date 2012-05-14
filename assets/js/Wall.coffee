#= require Vector
#= require LineSegment
#= require Intersection

class Wall

  constructor: (@line, @texture) ->
    throw 'Need a line and a texture' if not @line or not @texture

  @constructFromPoints: (point1, point2, texture) ->
    new Wall new LineSegment(point1, point2), texture

  @constructFromValues: (x1, y1, x2, y2, texture) ->
    @constructFromPoints new Vector(x1,y1), new Vector(x2,y2), texture

  computeIntersection: (ray) ->
    point = ray.computeIntersectionWithLine @line
    if (point) then new Intersection point, ray.getDistance(point), this, ray
    else null

  render: (canvas, player, column, intersection) ->
    context = canvas.getContext '2d'
    IMAGE_HEIGHT = 64
    IMAGE_WIDTH = 64
    distance = intersection.point.sub(player.position).pro(player.towards)
    context.drawImage @texture,
      Math.floor(IMAGE_WIDTH * intersection.point.dis(@line.point1) / @line.length()), #sx
      0, # sy
      1, # sWidth
      IMAGE_HEIGHT, #sHeight
      column, # dx
      Math.floor(canvas.height/2 - (canvas.height / distance)/2), #dy
      1, # dWidth
      Math.floor(canvas.height / distance) #dHeight

# Export
window.Wall = Wall
