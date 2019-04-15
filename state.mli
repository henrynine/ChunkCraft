open ANSITerminal
open Blocks
open Item

type chunk = {
  blocks : Blocks.block list list;
  coords : int * int
}

type inventory = {
  sets : (Item.item * int) list;
  max_size : int
}

type player = {
  color : ANSITerminal.style;
  coords : int * int;
  chunk_coords : int * int;
  character : char;
  inv : inventory
}

type map = {
  chunks : chunk list list;
  player : player
}

val inventory_max_size : unit -> int

val empty_inventory : unit -> inventory

val get_player_chunk_coords : map -> int * int

val get_player_coords : map -> int * int

val get_chunks : map -> chunk list list

val get_blocks : chunk -> Blocks.block list list

val get_player_color : map -> ANSITerminal.style

val get_player_character : map -> char

val move_player : map -> char -> map

val get_player_inventory : map -> inventory

val get_chunk_size : chunk -> int * int

val get_chunk_size_x : chunk -> int

val get_chunk_size_y : chunk -> int

val get_inventory_max_size : inventory -> int

val get_inventory_size : inventory -> int

val item_in_inventory : Item.item -> player -> bool

val get_inventory_sets : inventory -> (Item.item * int) list
