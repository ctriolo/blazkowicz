# Textures
window.TEXTURE = {}
TEXTURE.BRICK = new Image()
TEXTURE.BRICK.src = '/img/wall0.gif'
TEXTURE.STONE = new Image()
TEXTURE.STONE.src = '/img/wall1.gif'
TEXTURE.ROCK = new Image()
TEXTURE.ROCK.src =  '/img/wall2.gif'
TEXTURE.CAVE = new Image()
TEXTURE.CAVE.src =  '/img/wall3.gif'

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
  [' ', 'r', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 'c', ' ']
  [' ', 'r', ' ', ' ', ' ', 'r', 'c', ' ', ' ', ' ', 'c', ' ']
  [' ', 'r', 'r', 'r', 'r', 'r', 'c', 'c', 'c', 'c', 'c', ' ']
  [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']]
