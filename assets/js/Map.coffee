#= require_tree Math
#= require Wall
#= require Entity
#= require constants

class Map
  LEGEND = {}

  LEGEND.SPAWN = 'v'

  LEGEND.WALLS = [
    LEGEND.RED_BRICK    = 'R',
    LEGEND.BLUE_STONE   = 'B',
    LEGEND.GREY_STONE   = 'G',
    LEGEND.COLOR_STONE  = 'C',
    LEGEND.MOSSY_STONE  = 'M',
    LEGEND.PURPLE_STONE = 'P',
    LEGEND.WOOD         = 'W',
  ]

  LEGEND.ENTITIES = [
    LEGEND.BARREL      = 'b'
    LEGEND.PILLAR      = 'p'
    LEGEND.GREEN_LIGHT = 'g'
  ]


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
          # Spawn
          when LEGEND.SPAWN then @spawn = new Vector i+.5, j+.5
          # Wall
          when LEGEND.RED_BRICK then addBlock this, i, j, TEXTURE.RED_BRICK
          when LEGEND.BLUE_STONE then addBlock this, i, j, TEXTURE.BLUE_STONE
          when LEGEND.GREY_STONE then addBlock this, i, j, TEXTURE.GREY_STONE
          when LEGEND.COLOR_STONE then addBlock this, i, j, TEXTURE.COLOR_STONE
          when LEGEND.MOSSY_STONE then addBlock this, i, j, TEXTURE.MOSSY_STONE
          when LEGEND.PURPLE_STONE then addBlock this, i, j, TEXTURE.PURPLE_STONE
          when LEGEND.WOOD then addBlock this, i, j, TEXTURE.WOOD
          # Entities
          when LEGEND.BARREL then @entities.push Entity.barrel new Vector i+.5, j+.5
          when LEGEND.GREEN_LIGHT then @entities.push Entity.greenLight new Vector i+.5, j+.5
          when LEGEND.PILLAR then @entities.push Entity.pillar new Vector i+.5, j+.5

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

    visible.push min

    visible.sort (a, b) ->
      b.distance - a.distance

    return visible

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

    # Draw entities
    context.fillStyle = '#f0f'
    for i in [0...@array.length]
      for j in [0...@array[i].length]
        if (@array[i][j] in LEGEND.ENTITIES)
          context.beginPath()
          context.arc (i+.5) * 10,
            (j+.5) * 10, .5*10, 0, Math.PI * 2, true
          context.fill()

    # Draw player
    context.fillStyle = '#f00'
    context.beginPath()
    context.arc player.position.x * 10, player.position.y * 10, 2, 0, Math.PI * 2, true
    context.fill()

# Export
window.Map = Map
