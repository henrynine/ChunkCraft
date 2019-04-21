open Blocks
open Items

(** Convert [block] to an item set. *)
val block_to_item : Blocks.block -> (Items.item * int) option

(** Convert [item] to a block. *)
val item_to_block : Items.item -> Blocks.block option
