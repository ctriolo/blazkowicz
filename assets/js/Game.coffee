#= require constants
#= require Vector
#= require Player
#= require Map

class Game

  constructor: (@canvas) ->
    @map = new Map MAP_ARRAY
    @player = new Player @map.spawn, new Vector(1,0), .1, 3.1459/3
    @keys = new Array 128
    @updated = (new Date()).getTime()
    @update()

  render: ->
    intersections = [] # Keep track for mini-map

    # Render the background
    @map.renderBackground @canvas

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
    @player.moveLeft    dt if @keys[65] or @keys[37]
    @player.moveFoward  dt if @keys[87] or @keys[38]
    @player.moveRight   dt if @keys[68] or @keys[39]
    @player.moveBack    dt if @keys[83] or @keys[40]
    @player.rotateLeft  dt if @keys[81]
    @player.rotateRight dt if @keys[69]

    # Render everything
    @render()

    # Set this function to be called again
    callback = -> window.game.update()
    setTimeout callback, 16

  # Buffer key presses
  keyup: (key) -> @keys[key] = 0
  keydown: (key) -> @keys[key] = 1

# Export
window.Game = Game
