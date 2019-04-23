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
  preferred_tools : Items.item list;
  action : block -> (Items.item * int) list -> int ->
           (block * ((Items.item * int) list))
}

let grass : block = {
  character = ' ';
  color = ANSITerminal.black;
  background_color = ANSITerminal.on_green;
  styles = [ANSITerminal.Blink];
  ground = true;
  name = "grass";
  max_items = max_int;
  sets = [];
  preferred_tools = [];
  action = (fun b i m -> (b, i))
}

let tree : block = {
  character = 'T';
  color = ANSITerminal.yellow;
  background_color = ANSITerminal.on_green;
  styles = [ANSITerminal.Bold];
  ground = false;
  name = "tree";
  max_items = 0;
  sets = [];
  preferred_tools = [Items.wood_axe; Items.stone_axe];
  action = (fun b i m -> (b, i))
}

let water : block = {
  character = '~';
  color = ANSITerminal.white;
  background_color = ANSITerminal.on_blue;
  styles = [ANSITerminal.Blink];
  ground = false;
  name = "water";
  max_items = 0;
  sets = [];
  preferred_tools = [];
  action = (fun b i m -> (b, i))
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
  preferred_tools = [];
  action = (fun b i m -> (b, i))
}

let stone : block = {
  character = ' ';
  color = ANSITerminal.black;
  background_color = Colors.on_gray;
  styles = [];
  ground = false;
  name = "stone";
  max_items = 0;
  sets = [];
  preferred_tools = [Items.wood_pick; Items.stone_pick];
  action = (fun b i m -> (b, i))
}

let cobblestone : block = {
  character = 'X';
  color = ANSITerminal.black;
  background_color = Colors.on_gray;
  styles = [];
  ground = false;
  name = "cobblestone";
  max_items = 0;
  sets = [];
  preferred_tools = [];
  action = (fun b i m -> (b, i))
}

let rec closed_door : block = {
  character = 'X';
  color = ANSITerminal.black;
  background_color = Colors.on_brown;
  styles = [];
  ground = false;
  name = "closed door";
  max_items = 0;
  sets = [];
  preferred_tools = [];
  (* Hacky but works *)
  action = (fun b i m-> ({
    character = 'O';
    color = ANSITerminal.black;
    background_color = Colors.on_brown;
    styles = [];
    ground = true;
    name = "open door";
    max_items = 0;
    sets = [];
    preferred_tools = [];
    action = (fun b i m -> (closed_door, i))
  }, i))
}

let open_door : block = {
  character = 'O';
  color = ANSITerminal.black;
  background_color = Colors.on_brown;
  styles = [];
  ground = true;
  name = "open door";
  max_items = 0;
  sets = [];
  preferred_tools = [];
  action = (fun b i m -> (closed_door, i))
}

let get_block_color b = b.color
let get_block_background_color b = b.background_color
let get_block_character b = if List.length b.sets = 0 then b.character else '*'
let get_block_ground b = b.ground
let get_block_styles b = b.styles
let get_preferred_tools b = b.preferred_tools
let get_block_action b = b.action

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
