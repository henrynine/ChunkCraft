open Items
open Blocks

let blocks_to_items = [
  (Blocks.tree, (Items.log, 1));
  (Blocks.wood_plank, (Items.wood_plank, 1));
  (Blocks.stone, (Items.cobblestone, 1));
  (Blocks.cobblestone, (Items.cobblestone, 1));
  (Blocks.open_door, (Items.door, 1));
  (Blocks.closed_door, (Items.door, 1));
  (Blocks.furnace, (Items.furnace, 1));
  (Blocks.iron_ore, (Items.iron_ore, 1));
]

let items_to_blocks = [
  (Items.wood_plank, Blocks.wood_plank);
  (Items.cobblestone, Blocks.cobblestone);
  (Items.door, Blocks.closed_door);
  (Items.furnace, Blocks.furnace);
]

let block_to_item block = List.assoc_opt block blocks_to_items

let item_to_block item = List.assoc_opt item items_to_blocks
