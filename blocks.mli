open ANSITerminal
open Items

(** The type representing blocks. *)
type block = {
  character : char;
  color : ANSITerminal.style;
  background_color : ANSITerminal.style;
  styles : ANSITerminal.style list;
  ground : bool;
  name : string;
  max_items : int;
  sets : (Items.item * int) list;
  preferred_tools : Items.item list;
  action : block -> (Items.item * int) list -> int ->
           (block * ((Items.item * int) list));
  update : (block -> block) option
}

(** A grass block. *)
val grass : block
(** A grass block. *)
val tree : block
(** A grass block. *)
val water : block
(** A wood plank block. *)
val wood_plank : block
(** A stone block. *)
val stone : block
(** A cobblestone block. *)
val cobblestone : block
(** An open door block. *)
val open_door : block
(** A closed door block. *)
val closed_door : block
(** A chest block. *)
val chest : block
(** A furnace block. *)
val furnace : block

(** Get the color of [b]. *)
val get_block_color : block -> ANSITerminal.style
(** Get the background color of [b]. *)
val get_block_background_color : block -> ANSITerminal.style
(** Get the character of [b]. *)
val get_block_character : block -> char
(** Get the name of [b]. *)
val get_block_name : block -> string
(** Get the ground attribute of [b]. *)
val get_block_ground : block -> bool
(** Get the styles of [b]. *)
val get_block_styles : block -> ANSITerminal.style list
(** Get the action of [b] *)
val get_block_action : block -> (block -> (Items.item * int) list -> int ->
                                          (block * ((Items.item * int) list)))
(** Get the update of [b]. *)
val get_block_update : block -> (block -> block) option

(** Return [b] with [i] added to its sets. *)
val add_item_to_block : Items.item -> block -> block

(** Return [b] with [c] copies of [i] added to its sets. *)
val add_item_to_block_multiple : Items.item -> int -> block -> block

(** Return [b] with [c] copies of [i] removed from its sets. *)
val remove_item_from_block_multiple : Items.item -> int -> block -> block

(** Return how many sets are in [b]. *)
val count_sets_in_block : block -> int

(** Return the sets of [b]. *)
val sets_in_block : block -> (Items.item * int) list

(** Return [b] with all copies of its first item removed, as well as the item
  removed and how many copies were removed. *)
val take_first_item : block -> (block * Items.item * int)

val get_preferred_tools : block -> Items.item list
