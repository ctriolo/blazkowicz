window.EPSILON = .000001

# Textures
window.TEXTURE_HEIGHT = 64
window.TEXTURE_WIDTH = 64

addTexture = (src) ->
  image = new Image()
  image.src = src
  image

window.TEXTURE = {}

## Walls
TEXTURE.RED_BRICK    = addTexture '/img/wall/redbrick.png'
TEXTURE.BLUE_STONE   = addTexture '/img/wall/bluestone.png'
TEXTURE.GREY_STONE   = addTexture '/img/wall/greystone.png'
TEXTURE.COLOR_STONE  = addTexture '/img/wall/colorstone.png'
TEXTURE.MOSSY_STONE  = addTexture '/img/wall/mossy.png'
TEXTURE.PURPLE_STONE = addTexture '/img/wall/purplestone.png'
TEXTURE.WOOD         = addTexture '/img/wall/wood.png'

## Entities
TEXTURE.BARREL       = addTexture '/img/entity/barrel.png'
TEXTURE.PILLAR       = addTexture '/img/entity/pillar.png'
TEXTURE.GREEN_LIGHT  = addTexture '/img/entity/greenlight.png'

# Basic map array
window.MAP_ARRAY = [
  [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  [' ', 'R', 'R', 'R', 'R', 'R', 'G', 'G', 'G', 'G', 'G', ' ']
  [' ', 'R', ' ', 'g', ' ', 'R', 'G', ' ', ' ', ' ', 'G', ' ']
  [' ', 'R', 'g', ' ', 'g', ' ', ' ', ' ', 'p', ' ', 'G', ' ']
  [' ', 'R', ' ', 'g', ' ', 'R', 'G', ' ', ' ', ' ', 'G', ' ']
  [' ', 'R', 'R', ' ', 'R', 'R', 'G', 'G', ' ', 'G', 'G', ' ']
  [' ', 'B', 'B', ' ', 'B', 'B', 'W', 'W', ' ', 'W', 'W', ' ']
  [' ', 'B', ' ', ' ', ' ', 'B', 'W', 'b', ' ', 'b', 'W', ' ']
  [' ', 'B', ' ', 'v', ' ', ' ', ' ', ' ', ' ', ' ', 'W', ' ']
  [' ', 'B', ' ', ' ', ' ', 'B', 'W', 'b', ' ', 'b', 'W', ' ']
  [' ', 'B', 'B', 'B', 'B', 'B', 'W', 'W', 'W', 'W', 'W', ' ']
  [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']]
