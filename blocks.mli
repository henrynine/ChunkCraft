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
}

(** A grass block. *)
val grass : block
(** A grass block. *)
val tree : block
(** A grass block. *)
val water : block

(** Get the color of [b]. *)
val get_block_color : block -> ANSITerminal.style
(** Get the background color of [b]. *)
val get_block_background_color : block -> ANSITerminal.style
(** Get the character of [b]. *)
val get_block_character : block -> char
(** Get the ground attribute of [b]. *)
val get_block_ground : block -> bool
(** Get the styles of [b]. *)
val get_block_styles : block -> ANSITerminal.style list

(** Return [b] with [i] added to its sets. *)
val add_item_to_block : Items.item -> block -> block

(** Return [b] with [i] removed from its sets. *)
val remove_item_from_block : Items.item -> int -> block -> block

(** Return how many sets are in [b]. *)
val count_sets_in_block : block -> int

(** Return the sets of [b]. *)
val sets_in_block : block -> (Items.item * int) list

(** Return [b] with all copies of its first item removed, as well as the item removed
    and how many copies were removed. *)
val take_first_item : block -> (block * Items.item * int)
