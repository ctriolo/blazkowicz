#= require constants
#= require Vector
#= require Ray

class Player
  PLAYER_RADIUS        = .2
  TOP_LINEAR_VELOCITY  = 2 # per second
  LINEAR_ACCELERATION  = 2 # per second
  ANGULAR_VELOCITY     = 3.1459 # per second

  constructor: (@position, @towards, @distance, @angle) ->
    @velocity = new Vector 0, 0
    @acceleration = new Vector 0, 0
  right: -> new Vector(-@towards.y, @towards.x)

  # Movement and Direction
  moveFoward: () -> @acceleration = @acceleration.add @towards
  moveBack:   () -> @acceleration = @acceleration.sub @towards
  moveLeft:   () -> @acceleration = @acceleration.sub @right()
  moveRight:  () -> @acceleration = @acceleration.add @right()
  rotateRight: (dt) -> @towards = @towards.rot(ANGULAR_VELOCITY * dt)
  rotateLeft:  (dt) -> @towards = @towards.rot(-ANGULAR_VELOCITY * dt)

  # Update
  update : (dt, map) ->
    if (dt is 0) then return

    # Calculate acceleration for this time step
    @acceleration = @acceleration.nor().mul LINEAR_ACCELERATION

    # Redirect velocity into acceleration (TODO: necessary?)
    @velocity = @acceleration.nor().mul(@velocity.pro(@acceleration))

    # Add acceleration
    @velocity = @velocity.add @acceleration.mul dt

    # Clamp velocity
    if (@velocity.mag() > TOP_LINEAR_VELOCITY)
      @velocity = @velocity.nor().mul(TOP_LINEAR_VELOCITY)

    # Check for collision
    # TODO check vertical and horizontal displacement seperately
    #      to allow for sliding on the walls
    for direction in Vector.directions()
      if not @velocity.equ Vector.zero()
        corner = @position.add direction.mul PLAYER_RADIUS
        ray = new Ray corner, @velocity
        intersection = map.computeWallIntersection ray
        if intersection.distance < @velocity.mul(dt).mag()
          @velocity = @velocity.nor().mul (intersection.distance-EPSILON)/dt

    # Add to position
    @position = @position.add @velocity.mul dt

    # Reset acceleration
    @acceleration = new Vector 0, 0

  constructRay: (width, column) ->
    c = @position.add(@towards.mul(@distance))
    p1 = c.sub(@right().mul(@distance).mul(Math.tan(@angle/2)))
    p2 = c.add(@right().mul(@distance).mul(Math.tan(@angle/2)))
    p = p1.add((p2.sub(p1)).mul((column + .5) / width))
    v = p.sub(@position).div(p.sub(@position).mag())
    return new Ray(p,v)

# Export
window.Player = Player
