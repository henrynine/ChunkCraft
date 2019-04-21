open Items
open Blocks

let blocks_to_items = [
  (Blocks.tree, (Items.log, 1));
  (Blocks.wood_plank, (Items.wood_plank, 1));
  (Blocks.stone, (Items.stone, 1))
]

let items_to_blocks = [
  (Items.wood_plank, Blocks.wood_plank);
  (Items.stone, Blocks.stone)
]

let block_to_item block = List.assoc_opt block blocks_to_items

let item_to_block item = List.assoc_opt item items_to_blocks
