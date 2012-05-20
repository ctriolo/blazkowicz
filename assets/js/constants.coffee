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
MAP_STRINGS = [
  '            ',
  ' RRRRRGGGGG ',
  ' R l RG   G ',
  ' Rl l   p G ',
  ' R l RG   G ',
  ' RR RRWW WW ',
  ' B   BWb bW ',
  ' B v      W ',
  ' B   BWb bW ',
  ' BBBBBWWWWW ',
  '            ',
  ]

window.MAP_ARRAY = []
for string in MAP_STRINGS
  MAP_ARRAY.push string.split ''
