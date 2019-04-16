open ANSITerminal
open Items

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

val grass : block
val tree : block
val water : block

val get_block_color : block -> ANSITerminal.style
val get_block_background_color : block -> ANSITerminal.style
val get_block_character : block -> char
val get_block_ground : block -> bool
val get_block_styles : block -> ANSITerminal.style list

val add_item_to_block : Items.item -> block -> block

val remove_item_from_block : Items.item -> block -> block

val count_sets_in_block : block -> int

val sets_in_block : block -> (Items.item * int) list

val take_first_item : block -> (block * Items.item)
