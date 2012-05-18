#= require constants
#= require_tree Math

class Entity
  constructor: (@position, @texture, @tangible) ->

  line: (player) ->
    direction = player.towards.rot(Math.PI/2)
    p1 = @position.sub direction.mul .5
    p2 = @position.add direction.mul .5
    new LineSegment p1, p2

  computeCollision: (ray) ->
    return if not @tangible
    intersection = (new Circle @position, .5).computeIntersection ray
    intersection?.attach this
    intersection

  computeIntersection: (ray, player) ->
    intersection = @line(player).computeIntersection ray
    intersection?.attach this
    intersection

  render: (canvas, player, column, intersection) ->
    context = canvas.getContext '2d'
    line = @line(player)
    distance = intersection.point().sub(player.position).pro(player.towards)
    context.drawImage @texture,
      Math.floor(TEXTURE_WIDTH * intersection.point().dis(line.point1) / line.length()), #sx
      0, # sy
      1, # sWidth
      TEXTURE_HEIGHT, #sHeight
      column, # dx
      Math.floor(canvas.height/2 - (canvas.height / distance)/2), #dy
      1, # dWidth
      Math.floor(canvas.height / distance) #dHeight

  @pillar: (position) -> new Entity position, TEXTURE.PILLAR, true
  @barrel: (position) -> new Entity position, TEXTURE.BARREL, true
  @greenLight: (position) -> new Entity position, TEXTURE.GREEN_LIGHT, false

window.Entity = Entity
