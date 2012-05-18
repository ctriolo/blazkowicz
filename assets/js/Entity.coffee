#= require constants

class Entity
  constructor: (@position, @radius, @texture) ->

  computeIntersection: (ray) ->
    intersection = (new Circle position, .5).computeIntersection ray
    intersection?.attach this
    intersection

  render: (canvas, player, column, intersection) ->
    throw 'not correct'
    context = canvas.getContext '2d'
    IMAGE_HEIGHT = 64
    IMAGE_WIDTH = 64
    distance = intersection.point().sub(player.position).pro(player.towards)
    context.drawImage @texture,
      Math.floor(IMAGE_WIDTH * intersection.point().dis(@line.point1) / @line.length()), #sx
      0, # sy
      1, # sWidth
      IMAGE_HEIGHT, #sHeight
      column, # dx
      Math.floor(canvas.height/2 - (canvas.height / distance)/2), #dy
      1, # dWidth
      Math.floor(canvas.height / distance) #dHeight
