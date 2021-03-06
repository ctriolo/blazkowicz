#= require_tree ../Math
#= require ./Walls.js
#= require ./Entities.js

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
    LEGEND.GREEN_BARREL = 'b'
    LEGEND.PILLAR       = 'p'
    LEGEND.LIGHT        = 'l'
  ]

  constructor: (@array) ->
    @walls = []
    @entities = []
    addBlock = (type, a, b) =>
      @walls.push Wall.constructFromValues type,   a,   b, a+1,   b
      @walls.push Wall.constructFromValues type, a+1,   b, a+1, b+1
      @walls.push Wall.constructFromValues type, a+1, b+1,   a, b+1
      @walls.push Wall.constructFromValues type,   a, b+1,   a,   b
    for i in [0...@array.length]
      for j in [0...@array[i].length]
        switch(@array[i][j])
          # Spawn
          when LEGEND.SPAWN then @spawn = new Vector i+.5, j+.5
          # Wall
          when LEGEND.RED_BRICK    then addBlock RedBrick,    i, j
          when LEGEND.BLUE_STONE   then addBlock BlueStone,   i, j
          when LEGEND.GREY_STONE   then addBlock GreyStone,   i, j
          when LEGEND.PURPLE_STONE then addBlock PurpleStone, i, j
          when LEGEND.WOOD         then addBlock WoodPanel,   i, j
          # Entities
          when LEGEND.GREEN_BARREL then @entities.push new GreenBarrel new Vector i+.5, j+.5
          when LEGEND.LIGHT then @entities.push new Light new Vector i+.5, j+.5
          when LEGEND.PILLAR then @entities.push new Pillar new Vector i+.5, j+.5

  renderBackground: (canvas, VIEW_X, VIEW_Y, VIEW_WIDTH, VIEW_HEIGHT) ->
    context = canvas.getContext '2d'
    context.clearRect VIEW_X, VIEW_Y, VIEW_WIDTH, VIEW_HEIGHT
    context.fillStyle = '#CCC'
    context.fillRect VIEW_X, VIEW_Y, VIEW_WIDTH, VIEW_HEIGHT/2
    context.fillStyle = '#646464'
    context.fillRect VIEW_X, VIEW_Y + VIEW_HEIGHT/2, VIEW_WIDTH, VIEW_HEIGHT/2

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

    # Compute nearest entity collision
    for entity in @walls.concat @entities
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
