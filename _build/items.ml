type item = {
  name : string;
  stackable : bool;
  (* item list is what's needed to craft, int is how many you get *)
  recipe : ((item * int) list * int) option
}

let log : item = {
  name = "log";
  stackable = true;
  recipe = None
}

let wood_plank : item = {
  name = "wood plank";
  stackable = true;
  recipe = Some ([(log, 1)], 4)
}

let stick : item = {
  name = "stick";
  stackable = true;
  recipe = Some ([(wood_plank, 2)], 4)
}

let wood_pick : item = {
  name = "wood pick";
  stackable = false;
  recipe = Some ([(wood_plank, 3); (stick, 2)], 1)
}

let all_items = [
  log;
  wood_plank;
  stick;
]

let get_item_name i = i.name

let get_item_stackable i = i.stackable

let get_full_recipe i =
  match i.recipe with
  | None -> None
  | Some r -> Some r

let get_craft_count i =
  match i.recipe with
  | None -> None
  | Some (_, r) -> Some r

let item_in_set_list i l = List.fold_left (fun acc s -> (get_item_name i) = (get_item_name (fst s)) || acc) false l

let get_count_in_set_list i l =
  let s = List.find_opt (fun (i', c) -> i'.name = i.name) l in
  match s with
  | None -> 0
  | Some (i', c) -> c

(* TODO once stack limits are added, put them here *)
let add_to_set_list (i : item) (l : (item * int) list) =
  if item_in_set_list i l then
  (* Item is already present, increment the count in the set list *)
  (List.map (fun (i', c) -> if (get_item_name i') = (get_item_name i) then (i', c+1) else (i', c)) l)
  else
  (* Item is not present yet, add it with a count of 1 *)
  ((i, 1)::l)

let remove_from_set_list (i : item) (l : (item * int) list) =
  let s = List.map (fun (i', c) -> if (get_item_name i') = (get_item_name i) then (i', c-1) else (i', c)) l in
  List.filter (fun (i', c) -> c > 0) s

(* TODO once stack limits are added, put them here *)
let add_to_set_list_multiple (i : item) (c : int) (l : (item * int) list) =
  if item_in_set_list i l then
  (* Item is already present, increase the count in the set list *)
  (List.map (fun (i', c') -> if (get_item_name i') = (get_item_name i) then (i', c' + c) else (i', c')) l)
  else
  (* Item is not present yet, add it with a count of c *)
  ((i, c)::l)

let remove_from_set_list_multiple (i : item) (c : int) (l: (item * int) list) =
  let s = List.map (fun (i', c') -> if (get_item_name i') = (get_item_name i) then (i', c'-c) else (i', c')) l in
  if List.fold_left (fun a (i', c') -> (if c' < 0 then true else false) || a) false s then failwith "Can't remove that many"
  else List.filter (fun (i', c) -> c > 0) s