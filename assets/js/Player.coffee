#= require Vector
#= require Ray

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

# Export
window.Player = Player
