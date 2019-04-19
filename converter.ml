open Items
open Blocks

let blocks_to_items = [
  (Blocks.tree, (Items.log, 1));
]

let items_to_blocks = [
  (Items.wood_plank, Blocks.wood_plank);
]

let block_to_item block = List.assoc block blocks_to_items

let item_to_block item = List.assoc item items_to_blocks
