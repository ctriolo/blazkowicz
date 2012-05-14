#= require Game

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
