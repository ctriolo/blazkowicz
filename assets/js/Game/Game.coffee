#= require_tree ../Math
#= require constants
#= require Player
#= require Map

GAME_BACKGROUND = new Image()
GAME_BACKGROUND.src = '/img/gamebg.png'
HUD_BACKGROUND = new Image()
HUD_BACKGROUND.src = '/img/hudbg.png'

class Game

  constructor: (@canvas) ->
    @map = new Map MAP_ARRAY
    @player = new Player @map.spawn, new Vector(1,0), .1, 3.1459/3
    @keys = new Array 128
    @updated = (new Date()).getTime()
    @update()

  render: ->
    CANVAS_WIDTH = 400
    CANVAS_HEIGHT = 640
    VIEW_WIDTH = 608
    VIEW_HEIGHT = 304
    VIEW_X = 16
    VIEW_Y = 8
    HUD_X = 0
    HUD_Y = 320

    mmIntersections = []

    # Render the view background
    @map.renderBackground @canvas, VIEW_X, VIEW_Y, VIEW_WIDTH, VIEW_HEIGHT

    # Render the walls
    for column in [0...VIEW_WIDTH]
      ray = @player.constructRay VIEW_WIDTH, column
      intersections = @map.computeIntersections ray, @player
      for intersection in intersections
        intersection.object.render @canvas, VIEW_X, VIEW_Y, VIEW_WIDTH, VIEW_HEIGHT, @player, column, intersection
      mmIntersections.push intersections[0] if intersections[0]

    # Render the game background
    # Rendered after the view to hide drawings past the view box
    @canvas.getContext('2d').drawImage(GAME_BACKGROUND, 0, 0)

    # Render the mini-map
    #@map.renderMiniMap @canvas, @player, mmIntersections

    # Render the HUD
    @canvas.getContext('2d').drawImage(HUD_BACKGROUND, HUD_X, HUD_Y)

  update: ->

    # Calculate dt and update time
    old = @updated
    @updated = (new Date()).getTime()
    dt = (@updated - old) / 1000

    # Translate key presses into player actions
    @player.moveLeft    dt if @keys[65]
    @player.moveFoward  dt if @keys[87] or @keys[38]
    @player.moveRight   dt if @keys[68]
    @player.moveBack    dt if @keys[83] or @keys[40]
    @player.rotateLeft  dt if @keys[81] or @keys[37]
    @player.rotateRight dt if @keys[69] or @keys[39]
    @player.update dt, @map

    # Translate received key presses into enemy actions
    # TODO

    # Render everything
    @render()

    # Set this function to be called again
    callback = -> window.game.update()
    setTimeout callback, 35

  # Buffer key presses
  keyup: (key) -> @keys[key] = 0
  keydown: (key) -> @keys[key] = 1

# Export
window.Game = Game
