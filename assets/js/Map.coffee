#= require_tree Math
#= require Wall
#= require Entity
#= require constants

class Map
  LEGEND = {}
  LEGEND.SPAWN = 'p'
  LEGEND.BRICK = 'b'
  LEGEND.STONE = 's'
  LEGEND.CAVE  = 'c'
  LEGEND.ROCK  = 'r'
  LEGEND.WALLS = [LEGEND.BRICK, LEGEND.STONE, LEGEND.CAVE, LEGEND.ROCK]

  constructor: (@array) ->
    @walls = []
    @entities = []
    addBlock = (map, a, b, texture) ->
      map.walls.push Wall.constructFromValues   a,   b, a+1,   b, texture
      map.walls.push Wall.constructFromValues   a,   b,   a, b+1, texture
      map.walls.push Wall.constructFromValues a+1, b+1,   a, b+1, texture
      map.walls.push Wall.constructFromValues a+1, b+1, a+1,   b, texture
    for i in [0...@array.length]
      for j in [0...@array[i].length]
        switch(array[i][j])
          when 'r' then addBlock this, i, j, TEXTURE.RED_BRICK
          when 'b' then addBlock this, i, j, TEXTURE.BLUE_STONE
          when 's' then addBlock this, i, j, TEXTURE.GREY_STONE
          when 'c' then addBlock this, i, j, TEXTURE.COLOR_STONE
          when 'p' then @spawn = new Vector i+.5, j+.5
          when 'e' then @entities.push Entity.pillar new Vector i+.5, j+.5

  renderBackground: (canvas) ->
    context = canvas.getContext '2d'
    context.clearRect 0, 0, canvas.width, canvas.height
    context.fillStyle = '#BBB'
    context.fillRect 0, 0, canvas.width, canvas.height/2
    context.fillStyle = '#444'
    context.fillRect 0, canvas.height/2, canvas.width, canvas.height/2

  computeIntersections: (ray, player) ->

    # Compute closest wall intersections
    min = null
    for wall in @walls
      intersection = wall.computeIntersection ray
      if intersection? and (!min or intersection.distance < min.distance)
        min = intersection;

    # Computer entity intersections
    visible = []
    for entity in @entities
      intersection = entity.computeIntersection ray, player
      if intersection? and (!min or intersection.distance < min.distance)
        visible.push intersection;

    return [min, visible]

  computeCollision: (ray) ->
    min = null

    # Compute wall collision
    for wall in @walls
      intersection = wall.computeIntersection ray
      if intersection? and (!min or intersection.distance < min.distance)
        min = intersection

    # Computer entity collision
    for entity in @entities
      intersection = entity.computeCollision ray
      if intersection? and (!min or intersection.distance < min.distance)
        min = intersection

    return min

  renderMiniMap: (canvas, player, intersections) ->
    context = canvas.getContext '2d'

    # Draw blocks
    for i in [0...@array.length]
      for j in [0...@array[i].length]
        if (@array[i][j] in LEGEND.WALLS)
          if ((i+j)%2) then context.fillStyle = '#333'
          else context.fillStyle = '#000'
        else
          if ((i+j)%2) then context.fillStyle = '#fff'
          else context.fillStyle = '#bbb'
        context.fillRect(i * 10, j * 10, 10, 10)

    # Draw player->intersection
    context.strokeStyle = '#00f'
    context.beginPath()
    for intersection in intersections
      context.moveTo player.position.x * 10, player.position.y * 10
      context.lineTo intersection.point().x * 10, intersection.point().y * 10
    context.stroke()

    # Draw player
    context.fillStyle = '#f00'
    context.beginPath()
    context.arc player.position.x * 10, player.position.y * 10, 2, 0, Math.PI * 2, true
    context.fill()

# Export
window.Map = Map
