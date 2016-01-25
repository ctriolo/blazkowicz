#= require ./Entity.js

class Puddle extends Entity
  constructor: (position) -> super(position)
  tangible: -> false
  spriteOffsets: -> [0,0]
window.Puddle = Puddle

class GreenBarrel extends Entity
  constructor: (position) -> super(position)
  tangible: -> true
  spriteOffsets: -> [1,0]
window.GreenBarrel = GreenBarrel

class TableAndChairs extends Entity
  constructor: (position) -> super(position)
  tangible: -> true
  spriteOffsets: -> [2,0]
window.TableAndChairs = TableAndChairs

class Lamp extends Entity
  constructor: (position) -> super(position)
  tangible: -> true
  spriteOffsets: -> [3,0]
window.Lamp = Lamp

class Chandelier extends Entity
  constructor: (position) -> super(position)
  tangible: -> false
  spriteOffsets: -> [4,0]
window.Chandelier = Chandelier

class HangingSkeleton extends Entity
  constructor: (position) -> super(position)
  tangible: -> false
  spriteOffsets: -> [5,0]
window.HangingSkeleton = HangingSkeleton

class DogFood extends Entity
  constructor: (position) -> super(position)
  tangible: -> false
  spriteOffsets: -> [6,0]
window.DogFood = DogFood

class Pillar extends Entity
  constructor: (position) -> super(position)
  tangible: -> true
  spriteOffsets: -> [7,0]
window.Pillar = Pillar

class YellowPottedPlant extends Entity
  constructor: (position) -> super(position)
  tangible: -> true
  spriteOffsets: -> [8,0]
window.YellowPottedPlant = YellowPottedPlant

class Skeleton extends Entity
  constructor: (position) -> super(position)
  tangible: -> false
  spriteOffsets: -> [9,0]
window.Skeleton = Skeleton

class Sink extends Entity
  constructor: (position) -> super(position)
  tangible: -> true
  spriteOffsets: -> [10,0]
window.Sink = Sink

class BluePottedPlant extends Entity
  constructor: (position) -> super(position)
  tangible: -> true
  spriteOffsets: -> [11,0]
window.BluePottedPlant = BluePottedPlant

class BlueVase extends Entity
  constructor: (position) -> super(position)
  tangible: -> true
  spriteOffsets: -> [12,0]
window.BlueVase = BlueVase

class Table extends Entity
  constructor: (position) -> super(position)
  tangible: -> true
  spriteOffsets: -> [13,0]
window.Table = Table

class Light extends Entity
  constructor: (position) -> super(position)
  tangible: -> false
  spriteOffsets: -> [14,0]
window.Light = Light

class PotsAndPans extends Entity
  constructor: (position) -> super(position)
  tangible: -> false
  spriteOffsets: -> [15,0]
window.PotsAndPans = PotsAndPans

class Armor extends Entity
  constructor: (position) -> super(position)
  tangible: -> true
  spriteOffsets: -> [16,0]
window.Armor = Armor

class Cage extends Entity
  constructor: (position) -> super(position)
  tangible: -> true
  spriteOffsets: -> [17,0]
window.Cage = Cage

class CageWithSkeleton extends Entity
  constructor: (position) -> super(position)
  tangible: -> true
  spriteOffsets: -> [18,0]
window.CageWithSkeleton = CageWithSkeleton

class Bones extends Entity
  constructor: (position) -> super(position)
  tangible: -> true
  spriteOffsets: -> [19,0]
window.Bones = Bones

# TODO: Finish the rest
