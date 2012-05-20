#= require constants
#= require_tree Math

# Default Sprite Sheet and Dimensions
SPRITE_SHEET = new Image()
SPRITE_SHEET.src = '/img/entities.png'
SPRITE_DIMENSIONS = [128, 128]

class Entity
  constructor: (@position) ->

  line: (player) ->
    direction = player.towards.rot(Math.PI/2)
    p1 = @position.sub direction.mul .5
    p2 = @position.add direction.mul .5
    new LineSegment p1, p2

  computeCollision: (ray) ->
    return if not @tangible()
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
    [spriteWidth, spriteHeight] = @spriteDimensions()
    [spriteXOffset, spriteYOffset] = @spriteOffsets()
    spriteXOffset *= spriteWidth
    spriteYOffset *= spriteHeight
    distance = intersection.point().sub(player.position).pro(player.towards)
    context.drawImage @spriteSheet(),
      spriteXOffset + Math.floor(spriteWidth * intersection.point().dis(line.point1) / line.length()), #sx
      spriteYOffset + 0, # sy
      1, # sWidth
      spriteHeight, #sHeight
      column, # dx
      Math.floor(canvas.height/2 - (canvas.height / distance)/2), #dy
      1, # dWidth
      Math.floor(canvas.height / distance) #dHeight

  spriteSheet: -> SPRITE_SHEET
  spriteDimensions: -> SPRITE_DIMENSIONS
  tangible: -> throw 'Needs to be implemented by a sub-class.'
  spriteOffsets: -> throw 'Needs to be implemented by a sub-class.'

window.Entity = Entity
