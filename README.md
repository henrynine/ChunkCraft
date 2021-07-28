# ChunkCraft

ChunkCraft is a Minecraft-inspired 2D game that runs in a terminal emulator. Players can explore, build, craft, and hunt.

**Exploring near spawn**

<img src="https://github.com/henrynine/ChunkCraft/blob/master/gifs/wander.gif" width="300"/>

**Opening a house's door to go hunt a pig**

<img src="https://github.com/henrynine/ChunkCraft/blob/master/gifs/doorandpig.gif" width="300"/>

**Features**

* Procedurally generated map with trees, pigs, rocks, and ponds
* Crafting system with recipes
* Furnaces to smelt iron ore and cook pork chops
* Doors that can be opened and closed

**Controls**

* wasd to move (if you can't move past the edge of a chunk, either you've reached the edge of the map or there's an obstacle on the other side)
* m to enter mining mode (mining iron requires a stone or iron pick)
* i to view inventory
* c to craft
* e to enter interactive mode (for doors and furnaces)
* p to enter placement mode (whatever block you have equipped will be placed)

## Installation

1. Install OCaml and OPAM: https://ocaml.org/docs/install.html
2. Install the required packages using OPAM: 

`opam install utop ansiterminal ocamlbuild ounit qcheck yojson bisect`

3. Run `make play` from the ChunkCraft directory. The compiler will raise some alerts for features that were deprecated after ChunkCraft was written.

**Colors**

For optimal graphics, make the following color display changes in your terminal emulator's settings:

* macOS:
  * red -> burnt orange
  * yellow -> brown
  * magenta -> pink
  * cyan -> gray

* Ubuntu:
  * palette entry 1 -> burnt orange
  * palette entry 3 -> brown
  * palette entry 5 -> pink
  * palette entry 6 -> gray
  
  
