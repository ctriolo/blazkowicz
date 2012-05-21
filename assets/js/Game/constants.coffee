window.EPSILON = .000001

# Basic map array
MAP_STRINGS = [
  '            ',
  ' RRRRRGGGGG ',
  ' R l RG   G ',
  ' Rl l   p G ',
  ' R l RG   G ',
  ' RR RRGG GG ',
  ' BB BBWW WW ',
  ' B   BWb bW ',
  ' B v      W ',
  ' B   BWb bW ',
  ' BBBBBWWWWW ',
  '            ',
  ]

window.MAP_ARRAY = []
for string in MAP_STRINGS
  MAP_ARRAY.push string.split ''
