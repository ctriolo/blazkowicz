#= require Intersection

class Circle
  constructor: (@origin, @radius) ->

  computeIntersection: (ray) ->
    P = ray.point
    V = ray.vector
    O = @origin
    r = @radius
    L = O.sub(P)

    console.log P, V, O, r, L

    t_ca = L.dot(V)
    return if t_ca < 0

    d = Math.sqrt(L.dot(L) - (t_ca * t_ca))
    return if d > r

    t_hc = Math.sqrt(r*r - d*d)
    t1 = t_ca - t_hc
    t2 = t_ca + t_hc
    t = if t1 < t2 then t1 else t2

    new Intersection ray, t

window.Circle = Circle
