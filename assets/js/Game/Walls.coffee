#= require ./Wall.js

# TODO: Add a wall legend. Each wall associated with an id eg. 'W01'
# TODO: Finish adding walls.

class GreyStone extends Wall
  constructor: (line) -> super line
  spriteOffsets: -> [0, 0]
window.GreyStone = GreyStone

class GreyStone2 extends Wall
  constructor: (line) -> super line
  spriteOffsets: -> [0, 2]
window.GreyStone2 = GreyStone2

class GreyStoneBanner extends Wall
  constructor: (line) -> super line
  spriteOffsets: -> [0, 4]
window.GreyStoneBanner = GreyStoneBanner

class GreyStonePicture extends Wall
  constructor: (line) -> super line
  spriteOffsets: -> [0, 6]
window.GreyStonePicture = GreyStonePicture

class BlueStone extends Wall
  constructor: (line) -> super line
  spriteOffsets: -> [0, 14]
window.BlueStone = BlueStone

class BlueStone2 extends Wall
  constructor: (line) -> super line
  spriteOffsets: -> [0, 16]
window.BlueStone2 = BlueStone2

class WoodPanel extends Wall
  constructor: (line) -> super line
  spriteOffsets: -> [0, 22]
window.WoodPanel = WoodPanel

class RedBrick extends Wall
  constructor: (line) -> super line
  spriteOffsets: -> [0, 32]
window.RedBrick = RedBrick

class PurpleStone extends Wall
  constructor: (line) -> super line
  spriteOffsets: -> [0, 36]
window.PurpleStone = PurpleStone
