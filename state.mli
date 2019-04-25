open ANSITerminal
open Blocks
open Items
open Entities

type mode = Base | Mining | Placing | Interacting

(** A chunk is a sub-section of a map. One block represents a position within
    the chunk. [coords] is the coordinates of the chunk within the map. *)
type chunk = {
  blocks : Blocks.block list list;
  coords : int * int;
  entities : (Entities.entity * (int * int)) list
}

(** An inventory contains sets of items, which contain an item and a count. *)
type inventory = {
  sets : (Items.item * int) list;
  max_size : int
}

(** The type representing the player. [coords] represents the player's position
    within their current chunk. [character] is the character the player is
    displayed as in game. *)
type player = {
  color : ANSITerminal.style;
  coords : int * int;
  chunk_coords : int * int;
  character : char;
  inv : inventory;
  equipped_item : (item * int) option
}

(* The type representing the game map. *)
type map = {
  chunks : chunk list list;
  player : player;
  mode : mode;
  default_block : Blocks.block;
  game_is_paused : bool ref
}

(** The maximum inventory size. *)
val inventory_max_size : int

(** An empty inventory. *)
val empty_inventory : inventory

(** Get the coordinates of the player's current chunk within [m]. *)
val get_player_chunk_coords : map -> int * int

(** Get the coordinates of the player's current position within the current
    chunk in [m]. *)
val get_player_coords : map -> int * int

(** Get all the chunks in [m]. *)
val get_chunks : map -> chunk list list

(** Get all the blocks in [c]. *)
val get_blocks : chunk -> Blocks.block list list

(** Get the color used to represent the player in [m]. *)
val get_player_color : map -> ANSITerminal.style

(** Get the character used to represent the player in [m]. *)
val get_player_character : map -> char

(** Get the default block of [m]. *)
val get_default_block : map -> Blocks.block

(** Move the player within [m]. [c] of 'w' corresponds to up, 'a' to left,
   's' to down, 'd' to right.*)
val move_player : map -> char -> map

(** Get the player's current inventory. *)
val get_player_inventory : map -> inventory

(** Get the size of a chunk as a tuple. *)
val get_chunk_size : chunk -> int * int

(** Get the x size of a chunk. *)
val get_chunk_size_x : chunk -> int

(** Get the y size of a chunk. *)
val get_chunk_size_y : chunk -> int

(** Get the maximum size of an inventory. *)
val get_inventory_max_size : inventory -> int

(** Get the current size of an inventory. *)
val get_inventory_size : inventory -> int

(** Check if [i] is in the inventory of [p]. *)
val item_in_inventory : Items.item -> player -> bool

(** Get the count of [i] in the inventory of [p]. *)
val count_of_item_in_inv : Items.item -> player -> int

(** Get all the sets of items in [i]. *)
val get_inventory_sets : inventory -> (Items.item * int) list

(** Get the current mode of the map. *)
val get_map_mode : map -> mode

(** Get the entities of a chunk. *)
val get_entities : chunk -> ((Entities.entity * (int * int)) list)

(** Check if the inventory of [p] is full. *)
val inventory_is_full : player -> bool

(** Get the height of all chunks in [m]. *)
val get_chunk_height : map -> int

(** Get the width of all chunks in [m]. *)
val get_chunk_width : map -> int

(** Return [p] with [i] added. *)
val add_to_inventory : Items.item -> player -> player

(** Return [p] with [i] added [c] times. *)
val add_to_inventory_multiple : Items.item -> int -> player -> player

(** Return [p] with [i] removed. *)
val remove_from_inventory : Items.item -> player -> player

(** Return [p] with [i] removed [c] times. *)
val remove_from_inventory_multiple : Items.item -> int -> player -> player

(** Move the player's currently equipped item to their inventory, if they have
    one, and equip [c] counts of [i]. Returns the player with their equipped
    item and inventory updated. *)
val equip_item : Items.item -> int -> map -> player

(** Return [m] with the player's equipped item returned to their inventory. *)
val unequip_item : map -> map

(** Check whether the player in [m] has an item equipped. *)
val has_item_equipped : map -> bool

(** Return the currently equipped item of the player in [m]. *)
val equipped_item : map -> (Items.item * int) option

(** Return the block at position [x], [y] in [chunk] in [m]. *)
val get_block_in_chunk : chunk -> int -> int -> block

(** Get the current chunk of [m]. *)
val get_current_chunk : map -> chunk

(** Return [m] with [new_chunk] replacing the chunk at [x], [y] in [m]. *)
val replace_chunk_in_chunks : map -> chunk -> int -> int -> chunk list list

(** Return the chunk at [chunk_x], [chunk_y] in [m] with [nb] replacing the
    block at [x], [y] *)
val replace_block_in_chunk : map -> block -> int -> int -> int -> int -> chunk

(** Check if the inventory of the player in [m] is full. *)
val inventory_is_full_map : map -> bool

(** Return [map] with [count] copies of [item] added to the player's current
    block. *)
val drop_item : Items.item -> int -> map -> map

(** Mine the block in [direction], if it is valid. *)
val mine : map -> char -> map

(** Place the player's equipped item in [direction], if that is valid. *)
val place : map -> char -> map

(** Set the map to placing mode. *)

(** Set the map to mining mode. *)
val set_to_mining_mode : map -> map

(** Set the map to placing mode. *)
val set_to_placing_mode : map -> map

(** Set the map to base mode. *)
val set_to_base_mode : map -> map

(** Set the map to interacting mode. *)
val set_to_interacting_mode : map -> map

(** Check if the player in [map] has enough items in their inventory to craft
    [recipe]. *)
val player_has_enough_items : map -> (Items.item * int) list -> bool

(** Return a set list representing how many more of each item the player in
    [map] needs to craft [recipe]. *)
val sets_needed_to_craft : map -> (Items.item * int) list -> (Items.item * int) list

(** Update all entities and blocks in [m]. *)
val update_non_player_actions : map -> map

(** Carry out an interaction with the block in [direction] from the player's
    current location in [map]. *)
val interact : map -> char -> map

(** Generate a random map using [i] as the seed and [default_block] as the
    default block. *)
val generate_map : int -> Blocks.block -> map

(** Return [map] with all dead entities in [chunk] removed and their loot given
    to the player. *)
val remove_and_loot_dead_entities : map -> chunk -> map

(** Check if [map] is paused. *)
val is_paused : map -> bool

(** Pause [map]. *)
val pause : map -> unit

(** Unpause [map]. *)
val unpause : map -> unit
