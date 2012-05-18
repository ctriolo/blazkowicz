class Vector
  constructor: (@x, @y) ->
  add: (v) -> new Vector(@x+v.x, @y+v.y)
  sub: (v) -> new Vector(@x-v.x, @y-v.y)
  mul: (s) -> new Vector(@x*s, @y*s)
  div: (s) -> new Vector(@x/s, @y/s)
  mag: ()  -> Math.sqrt((@x * @x) + (@y * @y))
  dis: (v) -> Math.sqrt((@x - v.x) * (@x - v.x) + (@y - v.y) * (@y - v.y))
  nor: ()  -> if not @equ Vector.zero() then new Vector(@x/@mag(), @y/@mag()) else this
  rot: (a) -> new Vector(Math.cos(a)*@x - Math.sin(a)*@y, Math.sin(a)*@x + Math.cos(a)*@y)
  dot: (v) -> @x * v.x + @y * v.y
  pro: (v) -> if v.mag() then @dot(v) / v.mag() else 0
  equ: (v) -> @x is v.x and @y is v.y
  @zero:  -> new Vector  0,  0
  @north: -> new Vector  0,  1
  @south: -> new Vector  0, -1
  @east:  -> new Vector -1,  0
  @west:  -> new Vector  1,  0
  @northWest: -> @north().add(@west()).nor()
  @northEast: -> @north().add(@east()).nor()
  @southWest: -> @south().add(@west()).nor()
  @southEast: -> @south().add(@east()).nor()
  @directions: -> [@north(), @south(), @east(), @west(), @northEast(), @northWest()
    @southEast(), @southWest()]

# Export
window.Vector = Vector
