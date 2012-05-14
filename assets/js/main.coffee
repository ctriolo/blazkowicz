MAP_ARRAY = [
  [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  [' ', 'b', 'b', 'b', 'b', 'b', 's', 's', 's', 's', 's', ' ']
  [' ', 'b', ' ', ' ', ' ', 'b', 's', ' ', ' ', ' ', 's', ' ']
  [' ', 'b', ' ', 'p', ' ', ' ', ' ', ' ', ' ', ' ', 's', ' ']
  [' ', 'b', ' ', ' ', ' ', 'b', 's', ' ', ' ', ' ', 's', ' ']
  [' ', 'b', 'b', ' ', 'b', 'b', 's', 's', ' ', 's', 's', ' ']
  [' ', 'r', 'r', ' ', 'r', 'r', 'c', 'c', ' ', 'c', 'c', ' ']
  [' ', 'r', ' ', ' ', ' ', 'r', 'c', ' ', ' ', ' ', 'c', ' ']
  [' ', 'r', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 'c', ' ']
  [' ', 'r', ' ', ' ', ' ', 'r', 'c', ' ', ' ', ' ', 'c', ' ']
  [' ', 'r', 'r', 'r', 'r', 'r', 'c', 'c', 'c', 'c', 'c', ' ']
  [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']]

LEGEND = {}
LEGEND.SPAWN = 'p'
LEGEND.BRICK = 'b'
LEGEND.STONE = 's'
LEGEND.CAVE  = 'c'
LEGEND.ROCK  = 'r'
LEGEND.WALLS = [LEGEND.BRICK, LEGEND.STONE, LEGEND.CAVE, LEGEND.ROCK]

TEXTURE = {}
TEXTURE.BRICK = new Image()
TEXTURE.BRICK.src = '/img/wall0.gif'
TEXTURE.STONE = new Image()
TEXTURE.STONE.src = '/img/wall1.gif'
TEXTURE.ROCK = new Image()
TEXTURE.ROCK.src =  '/img/wall2.gif'
TEXTURE.CAVE = new Image()
TEXTURE.CAVE.src =  '/img/wall3.gif'

class Vector
  constructor: (@x, @y) ->
  add: (v) -> new Vector(@x+v.x, @y+v.y)
  sub: (v) -> new Vector(@x-v.x, @y-v.y)
  mul: (s) -> new Vector(@x*s, @y*s)
  div: (s) -> new Vector(@x/s, @y/s)
  mag: ()  -> Math.sqrt((@x * @x) + (@y * @y))
  dis: (v) -> Math.sqrt((@x - v.x) * (@x - v.x) + (@y - v.y) * (@y - v.y))
  nor: (v) -> new Vector(@x/@mag(), @y/@mag())
  rot: (a) -> new Vector(Math.cos(a)*@x - Math.sin(a)*@y, Math.sin(a)*@x + Math.cos(a)*@y)
  dot: (v) -> @x * v.x + @y * v.y
  pro: (v) -> @dot(v) / v.mag()

class LineSegment
  constructor: (@point1, @point2) ->
  length: () -> @point1.dis(@point2)

class Ray
  constructor: (@point, @vector) ->
  getPoint: (distance) -> @point.add(@vector.mul(distance))
  getDistance: (point) -> (point.x - @point.x) / @vector.x
  computeIntersectionWithRay: (ray) ->
    div = @vector.x * ray.vector.x - @vector.y * ray.vector.y
    if (div == 0)
      null
    else
      distance = (ray.vector.x*(ray.point.y - @point.y) +
        ray.vector.y*(@point.x - ray.point.x)) / div
      if distance <= 0
        return null
      else
        return @getPoint distance
  computeIntersectionWithHorizontalLine: (line) ->
    d = (line.point1.x - @point.x) / @vector.x
    return null if (d < 0)
    p = @getPoint d
    if ((line.point1.y < p.y < line.point2.y) or (line.point2.y < p.y < line.point1.y))
      p
    else
      null
  computeIntersectionWithVerticalLine: (line) ->
    d = (line.point1.y - @point.y) / @vector.y
    return null if (d < 0)
    p = @getPoint (line.point1.y - @point.y) / @vector.y
    if ((line.point1.x < p.x < line.point2.x) or (line.point2.x < p.x < line.point1.x))
      p
    else
      null
  computeIntersectionWithLine: (line) ->
    if (line.point1.x == line.point2.x)
      @computeIntersectionWithHorizontalLine(line)
    else if (line.point1.y == line.point2.y)
      @computeIntersectionWithVerticalLine(line)
    else
      alert('oops')
      ray = new Ray(line.point1, line.point1.sub(line.point2).nor())
      point = @computeIntersectionWithRay(ray)
      if !point || line.point1.dis(point) > line.length()
        null
      else
        point

# Scene classes

class Intersection
  constructor: (@point, @distance, @object, @ray) ->

class Wall
  constructor: (@line, @texture) ->
    @texture = TEXTURE.BRICK if (!@texture)
  computeIntersection: (ray) ->
    point = ray.computeIntersectionWithLine @line
    if (point) then new Intersection(point, ray.getDistance(point), this, ray)
    else null
  render: (canvas, player, column, intersection) ->
    context = canvas.getContext('2d')
    IMAGE_HEIGHT = 64
    IMAGE_WIDTH = 64
    sWidth = 1
    sHeight = IMAGE_HEIGHT
    sx = Math.floor(IMAGE_WIDTH * (intersection.point.dis(@line.point1) / @line.length()))
    sy = 0
    dWidth = 1
    distance = (intersection.point.sub(player.position).pro(player.towards))
    dHeight = Math.floor(canvas.height / distance)
    dx = column
    dy = Math.floor(canvas.height/2 - dHeight/2)
    context.drawImage(@texture, sx, sy, sWidth, sHeight, dx, dy, dWidth, dHeight)
  @constructFromPoints: (point1, point2, texture) ->
    new Wall(new LineSegment(point1, point2), texture)
  @constructFromValues: (x1, y1, x2, y2, texture) ->
    @constructFromPoints(new Vector(x1,y1), new Vector(x2,y2), texture)
  @

class Map

  constructor: (@array) ->
    @walls = []
    addBlock = (map, a, b, texture) ->
      map.walls.push Wall.constructFromValues   a,   b, a+1,   b, texture
      map.walls.push Wall.constructFromValues   a,   b,   a, b+1, texture
      map.walls.push Wall.constructFromValues a+1, b+1,   a, b+1, texture
      map.walls.push Wall.constructFromValues a+1, b+1, a+1,   b, texture
    for i in [0...@array.length]
      for j in [0...@array[i].length]
        switch(array[i][j])
          when 'b' then addBlock this, i, j, TEXTURE.BRICK
          when 's' then addBlock this, i, j, TEXTURE.STONE
          when 'r' then addBlock this, i, j, TEXTURE.ROCK
          when 'c' then addBlock this, i, j, TEXTURE.CAVE
          when 'p' then @spawn = new Vector i+.5, j+.5

  renderBackground: (canvas) ->
    context = canvas.getContext '2d'
    context.clearRect 0, 0, canvas.width, canvas.height
    context.fillStyle = '#BBB'
    context.fillRect 0, 0, canvas.width, canvas.height/2
    context.fillStyle = '#444'
    context.fillRect 0, canvas.height/2, canvas.width, canvas.height/2

  computeWall: (ray) ->
    min = null
    for wall in @walls
      intersection = wall.computeIntersection ray
      if (intersection and (!min or intersection.distance < min.distance))
        min = intersection;
    return min

  renderMiniMap: (canvas, player, intersections) ->
    context = canvas.getContext '2d'

    # Draw blocks
    for i in [0...@array.length]
      for j in [0...@array[i].length]
        if (@array[i][j] in LEGEND.WALLS)
          if ((i+j)%2) then context.fillStyle = "#333"
          else context.fillStyle = "#000"
        else
          if ((i+j)%2) then context.fillStyle = "#ddd"
          else context.fillStyle = "#fff"
        context.fillRect(i*10, j*10, 10, 10)

    # Draw rays
    #context.strokeStyle = "#0ff"
    #context.beginPath()
    #for ray in rays
    #  context.moveTo(ray.point.x*10,ray.point.y*10)
    #  context.lineTo(ray.point.add(ray.vector).x*10,ray.point.add(ray.vector).y*10)
    #context.stroke()

    # Draw player->intersection
    context.strokeStyle = "#00f"
    context.beginPath()
    for intersection in intersections
      context.moveTo(player.position.x*10,player.position.y*10)
      context.lineTo(intersection.point.x*10,intersection.point.y*10)
    context.stroke()

    # Draw player
    context.fillStyle = "#f00"
    context.beginPath()
    context.arc(player.position.x*10,player.position.y*10,2,0,Math.PI*2,true);
    context.fill()

    # Draw direction
    context.strokeStyle = "#0f0"
    context.beginPath()
    context.moveTo(player.position.x*10,player.position.y*10)
    context.lineTo(
      player.towards.add(player.position).x*10,
      player.towards.add(player.position).y*10)
    context.stroke()

class Player
  LINEAR_VELOCITY = 2 # per second
  ANGULAR_VELOCITY = 3.1459 # per second
  constructor: (@position, @towards, @distance, @angle) ->
  right: -> new Vector(-@towards.y, @towards.x)
  moveFoward: (dt) ->
    @position = @position.add(@towards.mul(LINEAR_VELOCITY * dt))
  moveBack: (dt) ->
    @position = @position.sub(@towards.mul(LINEAR_VELOCITY * dt))
  moveLeft: (dt) ->
    @position = @position.sub(@right().mul(LINEAR_VELOCITY * dt))
  moveRight: (dt) ->
    @position = @position.add(@right().mul(LINEAR_VELOCITY * dt))
  rotateRight: (dt) ->
    @towards = @towards.rot(ANGULAR_VELOCITY * dt)
  rotateLeft: (dt) ->
    @towards = @towards.rot(-ANGULAR_VELOCITY * dt)
  constructRay: (width, column) ->
    c = @position.add(@towards.mul(@distance))
    p1 = c.sub(@right().mul(@distance).mul(Math.tan(@angle/2)))
    p2 = c.add(@right().mul(@distance).mul(Math.tan(@angle/2)))
    p = p1.add((p2.sub(p1)).mul((column + .5) / width))
    v = p.sub(@position).div(p.sub(@position).mag())
    return new Ray(p,v)

class Game

  constructor: (@canvas) ->
    @map = new Map(MAP_ARRAY)
    @player = new Player(@map.spawn, new Vector(1,0), .1, 3.1459/3)
    @keys = new Array(128)
    @updated = (new Date()).getTime()
    @update()

  render: ->
    intersections = [] # Keep track for mini-map

    # Render the background
    @map.renderBackground(@canvas)

    # Render the walls
    for column in [0...@canvas.width]
      ray = @player.constructRay @canvas.width, column
      intersection = @map.computeWall ray
      intersections.push intersection if intersection?
      intersection?.object.render @canvas, @player, column, intersection

    # Render the mini-map
    @map.renderMiniMap @canvas, @player, intersections

  update: ->

    # Calculate dt and update time
    old = @updated
    @updated = (new Date()).getTime()
    dt = (@updated - old) / 1000

    # Translate key presses into player actions
    @player.moveLeft    dt if (@keys[65] || @keys[37])
    @player.moveFoward  dt if (@keys[87] || @keys[38])
    @player.moveRight   dt if (@keys[68] || @keys[39])
    @player.moveBack    dt if (@keys[83] || @keys[40])
    @player.rotateLeft  dt if (@keys[81])
    @player.rotateRight dt if (@keys[69])

    # Render everything
    @render()

    # Set this function to be called again
    callback = -> window.game.update()
    setTimeout callback, 16

  # Buffer key presses
  keyup: (key) -> @keys[key] = 0
  keydown: (key) -> @keys[key] = 1


# Main function

resize = ->
  h = Math.floor($(window).height()/10)
  w = Math.floor($(window).width()/16)
  u = if h < w then h else w
  $('canvas').width  u*16
  $('canvas').height u*10
  $('canvas').css({'margin-left': -(u*16)/2, 'margin-top': -(u*10)/2})
  $('canvas')[0].width = $('canvas').width()
  $('canvas')[0].height = $('canvas').height()

main = () =>
  $(window).resize resize
  $(window).resize()
  window.game = new Game($('canvas')[0])
  $(document).keyup (event) -> window.game.keyup event.which
  $(document).keydown (event) -> window.game.keydown event.which
  # attach mouses clicks
  # attach mouse movement

window.onload = main
