open ANSITerminal
open Blocks
open Items
open Converter

(* Types *)

type mode = Base | Mining | Placing

type chunk = {
  blocks : Blocks.block list list;
  coords : int * int
}

type inventory = {
  sets : (Items.item * int) list;
  max_size : int
}

type player = {
  color : ANSITerminal.style;
  coords : int * int;
  chunk_coords : int * int;
  character : char;
  inv : inventory;
  equipped_item : (Items.item * int) option
}

type map = {
  chunks : chunk list list;
  player : player;
  mode : mode;
  default_block : Blocks.block
}

(* End Types *)


(* Constants *)
let inventory_max_size = 10
(* End Constants *)


(* Helpers *)

let empty_inventory = {
  sets = [];
  max_size = inventory_max_size
}

let get_player_chunk_coords m = m.player.chunk_coords

let get_current_chunk m =
  let x, y = get_player_chunk_coords m in
  List.nth (List.nth m.chunks y) x

let get_player_coords m = m.player.coords

let get_chunks m = m.chunks

let get_blocks c = c.blocks

let get_block_in_chunk chunk block_x block_y =
  List.nth (List.nth (get_blocks chunk) block_y) block_x

let get_player_color m = m.player.color

let get_player_character m = m.player.character

let get_player_inventory m = m.player.inv

let get_chunk_size c = (List.length (List.hd c.blocks)), (List.length c.blocks)

let get_chunk_size_x c = get_chunk_size c |> fst

let get_chunk_size_y c = get_chunk_size c |> snd

let get_inventory_max_size i = i.max_size

let get_inventory_size i = List.length (i.sets)

let item_in_inventory i p = List.fold_left (fun acc s -> (Items.get_item_name i) = (Items.get_item_name (fst s)) || acc) false p.inv.sets

let set_to_mining_mode map =
  {map with mode = Mining}

let set_to_placing_mode map =
  {map with mode = Placing}

let set_to_base_mode map =
  {map with mode = Base}

let count_of_item_in_inv i p =
  let i' = List.find_opt (fun (i', c) -> Items.get_item_name i = Items.get_item_name i') p.inv.sets in
  match i' with
  | None -> 0
  | Some s -> snd s

let get_inventory_sets i = i.sets

let get_map_mode m = m.mode

let inventory_is_full p = (get_inventory_size p.inv) = (get_inventory_max_size p.inv)

let inventory_is_full_map m = inventory_is_full m.player

(* return the chunk in m at c_x c_y with nb at x y in that chunk*)
let replace_block_in_chunk m nb c_x c_y x y =
  let chunk = List.nth (List.nth m.chunks c_y) c_x in
  {chunk with blocks = List.mapi (fun i row -> if i = y then (List.mapi (fun i' b -> if i' = x then nb else b) row) else row) chunk.blocks}

(* return m.chunks with the chunk at x, y replaced with new_chunk *)
let replace_chunk_in_chunks m new_chunk x y =
  List.mapi (fun i row -> if i = y then (List.mapi (fun i' c -> if i' = x then new_chunk else c) row) else row) m.chunks

(* Assumes all chunks are the same height *)
let get_chunk_height m = (List.length (List.hd (List.hd m.chunks)).blocks)

(* End Helpers *)

(* player with item added to inventory or incremented, depending on which
   is appropriate *)
let add_to_inventory (i : Items.item) (p : player) : player =
  (* check if there is room in the player's inventory *)
  if (get_inventory_size p.inv) >= (get_inventory_max_size p.inv)
  then failwith "Inventory is full"
  else
  {p with
    inv = {p.inv with
             sets = Items.add_to_set_list i p.inv.sets}
  }

let add_to_inventory_multiple (i : Items.item) (c : int) (p : player) : player =
  if (get_inventory_size p.inv) >= (get_inventory_max_size p.inv)
  then failwith "Inventory is full"
  else
  {p with
    inv = {p.inv with
             sets = Items.add_to_set_list_multiple i c p.inv.sets}
  }

(* Player with: decrement count of item in player's inventory, if the count is then zero,
   remove it from the item *)
let remove_from_inventory (i: Items.item) (p:player) =
  if item_in_inventory i p then
  {p with
    inv = {p.inv with
      sets = Items.remove_from_set_list i p.inv.sets
    }
  }
  else
  failwith ("That item isn't in that character's inventory")

let remove_from_inventory_multiple (i: Items.item) (c : int) (p:player) =
  if item_in_inventory i p then
  {p with
    inv = {p.inv with
      sets = Items.remove_from_set_list_multiple i c p.inv.sets
    }
  }
  else
  failwith ("That item isn't in that character's inventory")

let equip_item i c m =
  match m.player.equipped_item with
  | None -> {m.player with equipped_item = Some (i, c)}
            |> remove_from_inventory_multiple i c
  | Some (i', c') ->
    begin
    let same_item = (Items.get_item_name i) = (Items.get_item_name i') in
    {m.player with equipped_item = if same_item then Some (i, c+c') else Some (i, c)}
              |> remove_from_inventory_multiple i c
              |> (if same_item then (fun x -> x) else
                 add_to_inventory_multiple i' c')
    end

let unequip_item m =
  match m.player.equipped_item with
  | None -> failwith "No item equipped"
  | Some s -> {m with player = ({m.player with equipped_item = None}
              |> add_to_inventory_multiple (fst s) (snd s))}

let has_item_equipped m =
  match m.player.equipped_item with
  | None -> false
  | Some _ -> true

let equipped_item m = m.player.equipped_item

let decrement_equipped_item player =
  match player.equipped_item with
    | None -> failwith "No item equipped"
    | Some (i, c) ->
      if c = 1 then
        ({player with equipped_item = None}, false)
      else
        ({player with equipped_item = Some (i, c-1)}, true)

let get_new_coords m c =
  let (player_x, player_y) = m.player.coords in
  let (player_chunk_x, player_chunk_y) = m.player.chunk_coords in
  let move_tuple =
    begin
      match c with
        | 'a' -> (-1, 0)
        | 'w' -> (0, -1)
        | 'd' -> (1 , 0)
        | 's' -> (0 , 1)
        | _ -> (0 , 0)
    end
    in
  (* Calculate the coordinates of the move if it is in the same chunk as before *)
  let (new_coords_x, new_coords_y) = (player_x + (fst move_tuple), player_y +
    (snd move_tuple)) in
  (* Grab the current chunk object *)
  let current_chunk = List.nth (List.nth m.chunks player_chunk_y)
    player_chunk_x in
  (* Calculate the coordinates of the new chunk on the chunk grid.
     Also, if the player moves chunks, then change their coords correspondingly.
     *)
  match (new_coords_x, new_coords_y) with
    | x, y when x >= get_chunk_size_x current_chunk ->
      (player_chunk_x + 1, player_chunk_y), (0, y)
    | x, y when y >= get_chunk_size_y current_chunk ->
      (player_chunk_x, player_chunk_y + 1), (x, 0)
    | x, y when x < 0 -> (player_chunk_x - 1, player_chunk_y),
      ((get_chunk_size_x current_chunk) - 1 , y)
    | x, y when y < 0 -> (player_chunk_x, player_chunk_y - 1),
      (x, (get_chunk_size_y current_chunk) - 1)
    | x, y -> (player_chunk_x , player_chunk_y), (x, y)

let is_different_chunk map new_chunk_x new_chunk_y =
  let (current_chunk_x, current_chunk_y) = get_player_chunk_coords map in
    (new_chunk_x <> current_chunk_x) || (new_chunk_y <> current_chunk_y)

let move_player m c : map =
  (* Check if the new chunk coordinates are valid *)
  let ((new_chunk_x, new_chunk_y), (final_coords_x, final_coords_y)) =
    get_new_coords m c in
  if new_chunk_x < 0 || new_chunk_x >= (List.length (List.hd m.chunks)) then m
  else if new_chunk_y < 0 || new_chunk_y >= (List.length m.chunks) then m
  else
  (* Set the new chunk *)
  let new_chunk = List.nth (List.nth m.chunks new_chunk_y) new_chunk_x in
  let next_block = get_block_in_chunk new_chunk final_coords_x final_coords_y
    in
  if Blocks.get_block_ground next_block then
    if Blocks.count_sets_in_block next_block > 0 then
      (* Item is ground and contains an item/items to be picked up *)
      (* Pick up all the items *)
      let rec loop nb p =
        if (Blocks.count_sets_in_block nb) = 0 || (inventory_is_full p) then
          {m with
              player = {p with
                coords = (final_coords_x, final_coords_y);
                chunk_coords = (new_chunk_x, new_chunk_y)};
              chunks = replace_chunk_in_chunks m (replace_block_in_chunk m nb
                new_chunk_x new_chunk_y final_coords_x final_coords_y)
                  new_chunk_x new_chunk_y}
        else let new_block, picked_up_item, num_removed =
          Blocks.take_first_item nb in
        let new_player =
          add_to_inventory_multiple picked_up_item num_removed p in
        loop new_block new_player in
      loop next_block m.player
    else {m with player = {m.player with coords =
      (final_coords_x, final_coords_y); chunk_coords =
        (new_chunk_x, new_chunk_y)}; mode = Base}
  else m

let drop_item item count map : map =
  let new_player = remove_from_inventory_multiple item count map.player in
  let (player_x, player_y) = get_player_coords map in
  let (player_chunk_x, player_chunk_y) = get_player_chunk_coords map in
  let new_block = get_block_in_chunk (get_current_chunk map) player_x
                                     player_y in
  let new_block_with_items = Blocks.add_item_to_block_multiple item count
                                                               new_block in
  let new_chunk = replace_block_in_chunk map new_block_with_items
                  player_chunk_x player_chunk_y player_x player_y in
  {map with player = new_player; chunks = (replace_chunk_in_chunks map
                                 new_chunk player_chunk_x player_chunk_y)}

let mine map direction : map =
  let ((new_chunk_x, new_chunk_y), (new_coords_x, new_coords_y)) =
    get_new_coords map direction in
  if (is_different_chunk map new_chunk_x new_chunk_y) then move_player map direction
  else
  begin
    let current_chunk = get_current_chunk map in
    let block_to_mine = get_block_in_chunk current_chunk new_coords_x new_coords_y in
    let preferred_tools = Blocks.get_preferred_tools block_to_mine in
    let player_tool = equipped_item map in
    let preferred_tool_is_equipped =
      begin
        match (match player_tool with | None -> None | Some (i, c) -> Some i) with
          | None -> false
          | Some tool -> List.mem tool preferred_tools
      end
    in
    if (get_block_ground block_to_mine || (match Converter.block_to_item block_to_mine with | None -> true | Some _ -> false))
      then move_player map direction
      else
        begin
          let (item, count) = match Converter.block_to_item block_to_mine with
            | Some (i, c) -> (i, c)
            | None -> failwith "Block not mineable" in

          let new_count =
            begin
              if preferred_tool_is_equipped
              then count * Items.get_preferred_multiplier
                (match player_tool with | None -> failwith "Should never get here"
                                        | Some (i, c) -> i)
              else count
            end
            in
          let new_player = add_to_inventory_multiple item new_count map.player in
          {map with player = new_player; mode = Base;
            chunks = replace_chunk_in_chunks map (replace_block_in_chunk map map.default_block
              new_chunk_x new_chunk_y new_coords_x new_coords_y)
                new_chunk_x new_chunk_y}
        end
  end

let place map direction : map =
  let ((chunk_x, chunk_y), (new_coords_x, new_coords_y)) =
    get_new_coords map direction in
  let current_chunk = get_current_chunk map in
  let block_to_place_in =
    get_block_in_chunk current_chunk new_coords_x new_coords_y in
  (* *)
  if (is_different_chunk map chunk_x chunk_y ||
      not (has_item_equipped map) ||
      not (get_block_ground block_to_place_in) ||
      (match map.player.equipped_item with
        | None -> true
        | Some (i, c) ->
          begin
          match Converter.item_to_block i with
          | None -> true
          | Some _ -> false
          end)
      ) then move_player map direction
  else
    begin
      let placed_block =
        match (Converter.item_to_block (match map.player.equipped_item with
            | None -> failwith "Shouldn't have gotten here"
            | Some (i, c) -> i)) with
        | None -> failwith "Shouldn't have gotten here"
        | Some b -> b in
      let new_player = fst (decrement_equipped_item map.player) in
      {map with player = new_player; mode = Base;
        chunks = replace_chunk_in_chunks map (replace_block_in_chunk map placed_block
          chunk_x chunk_y new_coords_x new_coords_y) chunk_x chunk_y}
    end
