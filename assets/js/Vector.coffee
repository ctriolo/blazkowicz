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

# Export
window.Vector = Vector
