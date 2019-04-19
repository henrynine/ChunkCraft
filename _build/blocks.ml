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
  sets : (Items.item * int) list
}

let grass : block = {
  character = ' ';
  color = ANSITerminal.black;
  background_color = ANSITerminal.on_green;
  styles = [ANSITerminal.Blink];
  ground = true;
  name = "grass";
  max_items = max_int;
  sets = []
}

let tree : block = {
  character = 'T';
  color = ANSITerminal.yellow;
  background_color = ANSITerminal.on_green;
  styles = [ANSITerminal.Bold];
  ground = false;
  name = "tree";
  max_items = 0;
  sets = []
}

let water : block = {
  character = '~';
  color = ANSITerminal.white;
  background_color = ANSITerminal.on_blue;
  styles = [ANSITerminal.Blink];
  ground = false;
  name = "water";
  max_items = 0;
  sets = []
}

let wood_plank : block = {
  character = ' ';
  color = ANSITerminal.black;
  background_color = Colors.on_brown;
  styles = [];
  ground = false;
  name = "wood plank";
  max_items = 0;
  sets = [];
}

let get_block_color b = b.color
let get_block_background_color b = b.background_color
let get_block_character b = if List.length b.sets = 0 then b.character else '*'
let get_block_ground b = b.ground
let get_block_styles b = b.styles

let add_item_to_block i b : block =
  if (List.length b.sets) >= b.max_items then failwith "Block is full"
  else {b with sets = Items.add_to_set_list i b.sets}

let add_item_to_block_multiple i c b =
  if (List.length b.sets) >= b.max_items then failwith "Block is full"
  else {b with sets = Items.add_to_set_list_multiple i c b.sets}

let remove_item_from_block_multiple i c b : block =
  if (List.length b.sets) = 0 then failwith "Block has no items"
  else {b with sets = Items.remove_from_set_list_multiple i c b.sets}

let count_sets_in_block b = List.length b.sets

let sets_in_block b = b.sets

let take_first_item (b : block) : (block * Items.item * int) =
  if List.length (b.sets) = 0 then failwith "No items in block"
  else let i, c = (List.nth b.sets 0) in
  ((remove_item_from_block_multiple i c b), i, c)
