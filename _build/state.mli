open ANSITerminal
open Blocks
open Items

type chunk = {
  blocks : Blocks.block list list;
  coords : int * int
}

type inventory = {
  sets : (Items.item * int) list;
  max_size : int
}

type player = {
  color : ANSITerminal.style;
  coords : int * int;
  chunk_coords : int * int;
  character : char;
  inv : inventory;
  equipped_item : (item * int) option
}

type map = {
  chunks : chunk list list;
  player : player;
  mining : bool
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

val item_in_inventory : Items.item -> player -> bool

val count_of_item_in_inv : Items.item -> player -> int

val get_inventory_sets : inventory -> (Items.item * int) list

val in_mining_mode : map -> bool

val inventory_is_full : player -> bool

val get_chunk_height : map -> int

val add_to_inventory : Items.item -> player -> player

val add_to_inventory_multiple : Items.item -> int -> player -> player

val remove_from_inventory : Items.item -> player -> player

val remove_from_inventory_multiple : Items.item -> int -> player -> player

val equip_item : Items.item -> int -> map -> player

val unequip_item : map -> map

val has_item_equipped : map -> bool

val equipped_item : map -> (Items.item * int) option

val get_block_in_chunk : map -> chunk -> int -> int -> block

val get_current_chunk : map -> chunk

val replace_chunk_in_chunks : map -> chunk -> int -> int -> chunk list list

val replace_block_in_chunk : map -> block -> int -> int -> int -> int -> chunk

val inventory_is_full_map : map -> bool
