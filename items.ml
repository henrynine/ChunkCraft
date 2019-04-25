type item = {
  name : string;
  stackable : bool;
  (* item list is what's needed to craft, int is how many you get *)
  recipe : ((item * int) list * int) option;
  preferred_multiplier : int;
  damage : int
}

let log : item = {
  name = "log";
  stackable = true;
  recipe = None;
  preferred_multiplier = 1;
  damage = 1;
}

let wood_plank : item = {
  name = "wood plank";
  stackable = true;
  recipe = Some ([(log, 1)], 4);
  preferred_multiplier = 1;
  damage = 1;
}

let stick : item = {
  name = "stick";
  stackable = true;
  recipe = Some ([(wood_plank, 2)], 4);
  preferred_multiplier = 1;
  damage = 1;
}

let wood_pick : item = {
  name = "wood pick";
  stackable = false;
  recipe = Some ([(wood_plank, 3); (stick, 2)], 1);
  preferred_multiplier = 2;
  damage = 1;
}

let wood_shovel : item = {
  name = "wood shovel";
  stackable = false;
  recipe = Some ([(wood_plank, 1); (stick, 2)], 1);
  preferred_multiplier = 2;
  damage = 1;
}

let wood_sword : item = {
  name = "wood sword";
  stackable = false;
  recipe = Some ([(wood_plank, 2); (stick, 1)], 1);
  preferred_multiplier = 2;
  damage = 2;
}

let wood_axe : item = {
  name = "wood axe";
  stackable = false;
  recipe = Some ([(wood_plank, 3); (stick, 2)], 1);
  preferred_multiplier = 2;
  damage = 2;
}

let stone : item = {
  name = "stone";
  stackable = true;
  recipe = None;
  preferred_multiplier = 1;
  damage = 1;
}

let cobblestone : item = {
  name = "cobblestone";
  stackable = true;
  recipe = None;
  preferred_multiplier = 1;
  damage = 1;
}

let stone_pick : item = {
  name = "stone pick";
  stackable = false;
  recipe = Some ([(cobblestone, 3); (stick, 2)], 1);
  preferred_multiplier = 3;
  damage = 2;
}

let stone_shovel : item = {
  name = "wood shovel";
  stackable = false;
  recipe = Some ([(cobblestone, 1); (stick, 2)], 1);
  preferred_multiplier = 3;
  damage = 2;
}

let stone_sword : item = {
  name = "stone sword";
  stackable = false;
  recipe = Some ([(cobblestone, 2); (stick, 1)], 1);
  preferred_multiplier = 3;
  damage = 3;
}

let stone_axe : item = {
  name = "stone axe";
  stackable = false;
  recipe = Some ([(cobblestone, 3); (stick, 2)], 1);
  preferred_multiplier = 3;
  damage = 3;
}

let door : item = {
  name = "door";
  stackable = true;
  recipe = Some ([(wood_plank, 2)], 1);
  preferred_multiplier = 1;
  damage = 1;
}

let pork_chop : item = {
  name = "pork chop";
  stackable = true;
  recipe = None;
  preferred_multiplier = 1;
  damage = 1;
}

let cooked_pork_chop : item = {
  name = "cooked pork chop";
  stackable = true;
  recipe = None;
  preferred_multiplier = 1;
  damage = 1;
}

let furnace : item = {
  name = "furnace";
  stackable = true;
  recipe = Some ([(cobblestone, 8)], 1);
  preferred_multiplier = 1;
  damage = 1;
}

let iron_ore : item = {
  name = "iron ore";
  stackable = true;
  recipe = None;
  preferred_multiplier = 1;
  damage = 1
}

let iron : item = {
  name = "iron";
  stackable = true;
  recipe = None;
  preferred_multiplier = 1;
  damage = 1;
}

let iron_pick : item = {
  name = "iron pick";
  stackable = false;
  recipe = Some ([(iron, 3); (stick, 2)], 1);
  preferred_multiplier = 4;
  damage = 3;
}

let iron_shovel : item = {
  name = "wood shovel";
  stackable = false;
  recipe = Some ([(iron, 1); (stick, 2)], 1);
  preferred_multiplier = 4;
  damage = 3;
}

let iron_sword : item = {
  name = "iron sword";
  stackable = false;
  recipe = Some ([(iron, 2); (stick, 1)], 1);
  preferred_multiplier = 4;
  damage = 5;
}

let iron_axe : item = {
  name = "iron axe";
  stackable = false;
  recipe = Some ([(iron, 3); (stick, 2)], 1);
  preferred_multiplier = 4;
  damage = 5;
}

let all_items = [
  log;
  wood_plank;
  stick;
  wood_pick;
  wood_shovel;
  wood_sword;
  wood_axe;
  stone;
  stone_pick;
  stone_shovel;
  stone_sword;
  stone_axe;
  cobblestone;
  door;
  pork_chop;
  cooked_pork_chop;
  furnace;
  iron;
  iron_ore;
  iron_pick;
  iron_shovel;
  iron_sword;
  iron_axe;
]

let get_item_name i = i.name

let get_item_stackable i = i.stackable

let get_preferred_multiplier i = i.preferred_multiplier

let get_damage i = i.damage

let get_full_recipe i =
  match i.recipe with
  | None -> None
  | Some r -> Some r

let get_craft_count i =
  match i.recipe with
  | None -> None
  | Some (_, r) -> Some r

let item_in_set_list i l = List.fold_left (fun acc s -> (get_item_name i) =
  (get_item_name (fst s)) || acc) false l

let get_count_in_set_list i l =
  let s = List.find_opt (fun (i', c) -> i'.name = i.name) l in
  match s with
  | None -> 0
  | Some (i', c) -> c

(* TODO once stack limits are added, put them here *)
let add_to_set_list (i : item) (l : (item * int) list) =
  if item_in_set_list i l then
  (* Item is already present, increment the count in the set list *)
  (List.map (fun (i', c) -> if (get_item_name i') = (get_item_name i)
  then (i', c+1) else (i', c)) l)
  else
  (* Item is not present yet, add it with a count of 1 *)
  ((i, 1)::l)

let remove_from_set_list (i : item) (l : (item * int) list) =
  let s = List.map (fun (i', c) -> if (get_item_name i') = (get_item_name i)
  then (i', c-1) else (i', c)) l in
  List.filter (fun (i', c) -> c > 0) s

(* TODO once stack limits are added, put them here *)
let add_to_set_list_multiple (i : item) (c : int) (l : (item * int) list) =
  if item_in_set_list i l then
  (* Item is already present, increase the count in the set list *)
  (List.map (fun (i', c') -> if (get_item_name i') = (get_item_name i)
  then (i', c' + c) else (i', c')) l)
  else
  (* Item is not present yet, add it with a count of c *)
  ((i, c)::l)

let remove_from_set_list_multiple (i : item) (c : int) (l: (item * int) list) =
  let s = List.map (fun (i', c') -> if (get_item_name i') = (get_item_name i)
  then (i', c'-c) else (i', c')) l in
  if List.fold_left (fun a (i', c') -> (if c' < 0 then true else false) || a)
    false s then failwith "Can't remove that many"
  else List.filter (fun (i', c) -> c > 0) s
