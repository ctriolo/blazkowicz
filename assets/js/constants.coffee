window.EPSILON = .000001

# Textures
window.TEXTURE_HEIGHT = 64
window.TEXTURE_WIDTH = 64

window.TEXTURE = {}
TEXTURE.RED_BRICK = new Image()
TEXTURE.RED_BRICK.src = '/img/wall/redbrick.png'
TEXTURE.BLUE_STONE = new Image()
TEXTURE.BLUE_STONE.src = '/img/wall/bluestone.png'
TEXTURE.GREY_STONE = new Image()
TEXTURE.GREY_STONE.src = '/img/wall/greystone.png'
TEXTURE.COLOR_STONE = new Image()
TEXTURE.COLOR_STONE.src = '/img/wall/colorstone.png'
TEXTURE.MOSSY_STONE = new Image()
TEXTURE.MOSSY_STONE.src = '/img/wall/mossy.png'
TEXTURE.PURPLE_STONE = new Image()
TEXTURE.PURPLE_STONE.src = '/img/wall/purplestone.png'
TEXTURE.WOOD = new Image()
TEXTURE.WOOD.src = '/img/wall/wood.png'

TEXTURE.PILLAR = new Image()
TEXTURE.PILLAR.src = '/img/entity/pillar.png'

# Basic map array
window.MAP_ARRAY = [
  [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']
  [' ', 'b', 'b', 'b', 'b', 'b', 's', 's', 's', 's', 's', ' ']
  [' ', 'b', ' ', ' ', ' ', 'b', 's', ' ', ' ', ' ', 's', ' ']
  [' ', 'b', ' ', 'p', ' ', ' ', ' ', ' ', ' ', ' ', 's', ' ']
  [' ', 'b', ' ', ' ', ' ', 'b', 's', ' ', ' ', ' ', 's', ' ']
  [' ', 'b', 'b', ' ', 'b', 'b', 's', 's', ' ', 's', 's', ' ']
  [' ', 'r', 'r', ' ', 'r', 'r', 'c', 'c', ' ', 'c', 'c', ' ']
  [' ', 'r', ' ', ' ', ' ', 'r', 'c', ' ', ' ', ' ', 'c', ' ']
  [' ', 'r', ' ', 'e', ' ', ' ', ' ', ' ', ' ', ' ', 'c', ' ']
  [' ', 'r', ' ', ' ', ' ', 'r', 'c', ' ', ' ', ' ', 'c', ' ']
  [' ', 'r', 'r', 'r', 'r', 'r', 'c', 'c', 'c', 'c', 'c', ' ']
  [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']]
