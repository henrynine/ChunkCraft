open Items
open Blocks

let blocks_to_items = [
  ("tree", (Items.log, 1));
  ("wood plank", (Items.wood_plank, 1));
  ("stone", (Items.cobblestone, 1));
  ("cobblestone", (Items.cobblestone, 1));
  ("open door", (Items.door, 1));
  ("closed door", (Items.door, 1));
  ("furnace", (Items.furnace, 1));
  ("iron ore", (Items.iron_ore, 1));
]

let items_to_blocks = [
  (Items.wood_plank, Blocks.wood_plank);
  (Items.cobblestone, Blocks.cobblestone);
  (Items.door, Blocks.closed_door);
  (Items.furnace, Blocks.furnace);
]

let block_to_item block =
  List.assoc_opt (Blocks.get_block_name block) blocks_to_items

let item_to_block item = List.assoc_opt item items_to_blocks
