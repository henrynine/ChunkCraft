open ANSITerminal
open Blocks
open Items
open Converter
open Random
open QCheck
open Entities

(* Types *)

type mode = Base | Mining | Placing | Interacting

type chunk = {
  blocks : Blocks.block list list;
  coords : int * int;
  entities: ((Entities.entity * (int * int)) list)
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
  default_block : Blocks.block;
  game_is_paused : bool ref
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

let get_chunk_in_map map chunk_x chunk_y =
  List.nth (List.nth (get_chunks map) chunk_y) chunk_x

let get_default_block m = m.default_block

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

let set_to_interacting_mode map =
  {map with mode = Interacting}

let is_paused map = !(map.game_is_paused)

let pause map = map.game_is_paused := true

let unpause map = map.game_is_paused := false

let count_of_item_in_inv i p =
  let i' = List.find_opt (fun (i', c) -> Items.get_item_name i = Items.get_item_name i') p.inv.sets in
  match i' with
  | None -> 0
  | Some s -> snd s

let get_inventory_sets i = i.sets

let get_map_mode m = m.mode

let inventory_is_full p = (get_inventory_size p.inv) = (get_inventory_max_size p.inv)

let inventory_is_full_map m = inventory_is_full m.player

let get_entities c = c.entities

(* return the chunk in m at c_x c_y with nb at x y in that chunk*)
let replace_block_in_chunk m nb c_x c_y x y =
  let chunk = List.nth (List.nth m.chunks c_y) c_x in
  {chunk with blocks = List.mapi (fun i row -> if i = y then (List.mapi (fun i' b -> if i' = x then nb else b) row) else row) chunk.blocks}

let replace_block_in_chunk_no_map new_block x y chunk =
  {chunk with blocks = List.mapi (fun i row -> if i = y then (List.mapi (fun i' b -> if i' = x then new_block else b) row) else row) chunk.blocks}

(* return m.chunks with the chunk at x, y replaced with new_chunk *)
let replace_chunk_in_chunks m new_chunk x y =
  List.mapi (fun i row -> if i = y then (List.mapi (fun i' c -> if i' = x then new_chunk else c) row) else row) m.chunks

(* Assumes all chunks are the same height *)
let get_chunk_height m = get_chunk_size_y (m.chunks |> List.hd |> List.hd)
let get_chunk_width m = get_chunk_size_x (m.chunks |> List.hd |> List.hd)

let has_entity_at_coords chunk x y =
  ((List.filter (fun (_, (x',y')) -> x' = x && y' = y) chunk.entities)
   |> List.length) > 0

let replace_entity chunk x y new_entity new_x new_y =
  if has_entity_at_coords chunk x y then
    {chunk with entities =
      List.map (fun (e, (x', y')) -> if x' = x && y' = y then
        (new_entity, (new_x, new_y))
      else (e, (x', y'))) chunk.entities}
  else
    {chunk with entities = (new_entity, (x, y))::chunk.entities}

let entity_at chunk x y =
  if (not (has_entity_at_coords chunk x y)) then
    failwith "No entity at this location"
  else
    List.filter (fun (e, (x', y')) -> x = x' && y = y') chunk.entities
    |> List.hd
    |> fst


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

let get_equipped_item_damage m =
  match m.player.equipped_item with
  | None -> 1
  | Some (i, c) -> Items.get_damage i

(* return the map with player changed and chunk changed*)
let remove_and_loot_dead_entities map chunk =
  (* TODO this could fail if it overfills the player's inventory – this might affect other functions too *)
  let new_player, new_chunk =
    (* Filter chunk for entities with health < 0 and fold to get a list of coords of dead entities and a list of player loot *)
    List.filter (fun (e, (x, y)) -> Entities.get_health e <= 0) chunk.entities
    (* Fold on entities with acc of (player, chunk) to return (player with items added, chunk with entities removed) *)
    |> List.fold_left (fun (p, c) (e, (x, y)) ->
          (let i, c' = Entities.get_loot e in
          (add_to_inventory_multiple i c' p,
          {c with entities = List.filter (fun (_, (x', y')) -> not ((x' = x) && (y' = y))) c.entities}))) (map.player, chunk)
  in {map with player = new_player;
          chunks = replace_chunk_in_chunks map new_chunk (fst chunk.coords) (snd chunk.coords)}

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
  (* TODO can currently attack entities across chunks – bad idea *)
  if (Blocks.get_block_ground next_block && (not (has_entity_at_coords new_chunk final_coords_x final_coords_y)))then
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
  else if (has_entity_at_coords new_chunk final_coords_x final_coords_y) then
    begin
    (* DEBUG *)
    (* ANSITerminal.erase ANSITerminal.Screen;
    ANSITerminal.set_cursor 1 1;
    print_endline "moved onto entity";
    while (input_char Pervasives.stdin <> 'n') do 1+1 done; *)
    (* END DEBUG *)
    (* Do combat between entity and player *)
    (* TODO for now we only have pigs, but later, this should check for an
       attack in the entity and go at the player *)
    let current_chunk = get_current_chunk m in
    let current_entity = entity_at current_chunk final_coords_x final_coords_y in
    let new_chunk = replace_entity current_chunk final_coords_x final_coords_y {current_entity with health = current_entity.health - (get_equipped_item_damage m)} final_coords_x final_coords_y in
    (* map with final chunk replacing current chunk, player with any items added and later maybe health decreased *)
    remove_and_loot_dead_entities m new_chunk
    end
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
          let player_tool_can_mine_iron =
            match player_tool with
            | None -> false
            | Some (i, c) -> (Items.get_item_name i = "iron pick") || (Items.get_item_name i = "stone pick") in
          let name_of_block_to_mine = Blocks.get_block_name block_to_mine in
          let new_player = add_to_inventory_multiple item new_count map.player in
          if (name_of_block_to_mine = "iron ore") && not(player_tool_can_mine_iron) then map else
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
  (* TODO remove this redundancy *)
  if (is_different_chunk map chunk_x chunk_y)
    then map
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

let interact map direction : map =
  pause map;
  let ((chunk_x, chunk_y), (new_coords_x, new_coords_y)) =
    get_new_coords map direction in
  let current_chunk = get_current_chunk map in
  let block_to_interact_with =
    get_block_in_chunk current_chunk new_coords_x new_coords_y in
  if (is_different_chunk map chunk_x chunk_y) then move_player map direction
  else
  let new_block, new_inv_sets = (Blocks.get_block_action block_to_interact_with)
      block_to_interact_with (map.player.inv.sets) (map.player.inv.max_size) in
  let res = {map with player =
    {map.player with inv = {map.player.inv with sets = new_inv_sets}};
    mode = Base;
    chunks = replace_chunk_in_chunks map
      (replace_block_in_chunk map new_block chunk_x chunk_y
          new_coords_x new_coords_y)
      chunk_x chunk_y} in
  unpause map;
  res

let sets_needed_to_craft map recipe =
  (* Get the raw list of items in the recipe and how many more are
     needed in the player's inventory to craft it, then filter out any
     items that have a count of zero or less, i.e. the player has enough
     in their inventory already. *)
  (List.fold_left (fun acc (i', c) ->
        Items.add_to_set_list_multiple i'
        (c - (Items.get_count_in_set_list i' map.player.inv.sets)) acc) []
        recipe)
  |> List.filter (fun (i', c) -> c > 0)

let player_has_enough_items map recipe =
  List.length (sets_needed_to_craft map recipe) = 0

(*  TODO update entities *)
let update_non_player_actions map =
  (* Go through map – if hit an entity, update it *)
  (* Later update to at least include furnaces, maybe be more elegant *)

  let update_entity (entity, coords) chunk =
    let x, y = coords in
    let (new_entity, (new_x, new_y)) = ((Entities.get_update entity) (entity, coords)) in
    (* TODO simplify update since max x y checking is no longer the responsibility of updating entity *)
    (* if (new_x, new_y isn't ground or is the player's location then no go otherwise good) *)
    if (new_x <= 0 || new_x >= get_chunk_size_x chunk || new_y <= 0 || new_y >= get_chunk_size_y chunk)
       || ((new_x, new_y) = map.player.coords && chunk.coords = (get_current_chunk map).coords)
       || (not (get_block_in_chunk chunk new_x new_y
                |> Blocks.get_block_ground))
       || has_entity_at_coords chunk new_x new_y then chunk
    else replace_entity chunk x y new_entity new_x new_y in

  let update_block block =
    match (Blocks.get_block_update block) with
    | None -> block
    | Some f -> (f block) in

  let update_entities_chunk chunk =
    List.fold_left (fun a (e, (x, y)) -> update_entity (e, (x, y)) a) chunk
      chunk.entities in

  let update_blocks_chunk chunk =
    {chunk with blocks =
      List.map (fun r -> List.map (update_block) r) chunk.blocks} in

  {map with chunks = List.map (fun r -> List.map
       (fun c -> update_entities_chunk c |> update_blocks_chunk) r) map.chunks}


let generate_map i default_block =
  Random.init i;
  let rec repeat f a n = if n = 0 then a else repeat f (f a n) (n-1) in
  let add_grass_to_list a n = Blocks.grass::a in
  let chunk_height, chunk_width = (24, 38) in
  let map_height, map_width = (20, 20) in
  let grass_row = repeat add_grass_to_list [] chunk_width in
  let add_grass_row_to_list a n = grass_row::a in
  let blank_chunk = {
    blocks = repeat add_grass_row_to_list [] chunk_height;
    coords = (0,0);
    entities = [];
  } in


  let dist (x_1, y_1) (x_2, y_2) =
    Pervasives.sqrt (((float_of_int x_2 -. float_of_int x_1) ** 2.) +.
    ((float_of_int y_2 -. float_of_int y_1) ** 2.)) in

  let create_pond x y chunk =
    (* how does this never go out of chunk bounds? a: clusters are only spawned
       at least four blocks away from chunk edge, and this never goes past
       that*)
    let initial_pond_coords = (Random.int chunk_width) , (Random.int chunk_height) in
    let chunk_blocks = get_blocks chunk in
    let new_blocks = List.mapi (fun y row -> List.mapi (fun x block ->
        let dist_from_center = int_of_float(dist (fst initial_pond_coords, snd initial_pond_coords) (x,y)) in
        if dist_from_center < 2
            then Blocks.water
            else if dist_from_center < 3
              then if (Random.int 11) < 6
                then Blocks.water
                else block
              else block
        ) row ) chunk_blocks in
    {chunk with blocks = new_blocks} in

  let create_boulder x y chunk =
    (* how does this never go out of chunk bounds? a: clusters are only spawned
        at least four blocks away from chunk edge, and this never goes past
        that*)
    let initial_pond_coords = (Random.int chunk_width) , (Random.int chunk_height) in
    let chunk_blocks = get_blocks chunk in
    let new_blocks = List.mapi (fun y row -> List.mapi (fun x block ->
        let dist_from_center = int_of_float(dist (fst initial_pond_coords, snd initial_pond_coords) (x,y)) in
        let spawn_number = (Random.int 20) in
        let block_to_place = if spawn_number = 0 then Blocks.iron_ore else Blocks.stone in
        if dist_from_center < 2
            then block_to_place
            else if dist_from_center < 3
              then if (Random.int 11) < 4
                then block_to_place
                else block
              else block
        ) row ) chunk_blocks in
    {chunk with blocks = new_blocks} in

  (* let create_boulder x y chunk =
    let total_size = (Random.int 4) + 4 in *)

  let create_forest x y chunk =
    let total_trees = (Random.int 5) + 8 in
    let place_tree x' y' c' =
      if x' < 0 || x' > get_chunk_size_x chunk
         || y' < 0 || y' > get_chunk_size_y chunk then c'
      else replace_block_in_chunk_no_map Blocks.tree x' y' c' in
    let place_random_tree c' n =
      let x_adjust = (Random.int 9) - 4 in
      let y_adjust = (Random.int 9) - 4 in
      place_tree (x + x_adjust) (y + y_adjust) c' in
    repeat place_random_tree chunk total_trees in

  let create_pigs x y chunk =
    let total_pigs = (Random.int 2) + 2 in
    let place_pig x' y' c' =
      if x' < 0 || x' > get_chunk_size_x chunk
         || y' < 0 || y' > get_chunk_size_y chunk then c'
      else
       let e_chunk = replace_entity c' x' y' Entities.pig x' y' in
       replace_block_in_chunk_no_map default_block x' y' e_chunk
      in
    let place_random_pig c' n =
      let x_adjust = (Random.int 9) - 4 in
      let y_adjust = (Random.int 9) - 4 in
      place_pig (x + x_adjust) (y + y_adjust) c' in
    repeat place_random_pig chunk total_pigs in

  let all_cluster_functions_but_pond =
    [create_forest; create_boulder; create_pigs] in

  let populate_chunk c =
    let num_clusters = (Random.int 5) + 5 in
    let num_ponds = (Random.int 3) + 1 in
    let create_cluster cluster_generation_function c' =
      let x' = (Random.int (get_chunk_size_x c - 7)) + 4 in
      let y' = (Random.int (get_chunk_size_y c - 7)) + 4 in
      cluster_generation_function x' y' c' in
    let create_random_cluster c' n =
      create_cluster (List.hd (QCheck.Gen.(generate1 (shuffle_l all_cluster_functions_but_pond)))) c' in
    let pondless_chunk = repeat create_random_cluster c num_clusters in
    repeat (fun c' n -> create_cluster create_pond c') pondless_chunk num_ponds in

  let chunk_row y = repeat (fun a n -> ({(populate_chunk blank_chunk) with coords = (n - 1), y})::a) [] map_width in

  let find_clear_coords chunk =
    let x' = ref (Random.int ((get_chunk_size_x chunk) - 7) + 4) in
    let y' = ref (Random.int ((get_chunk_size_y chunk) - 7) + 4) in
    while (Blocks.get_block_name (get_block_in_chunk chunk (!x') (!y')) <> "grass") do
      x' := (Random.int ((get_chunk_size_x chunk) - 7) + 4);
      y' := (Random.int ((get_chunk_size_x chunk) - 7) + 4)
    done;
    (!x'), (!y') in

  let populated_map = {
    chunks = repeat (fun a n -> (chunk_row (n-1))::a) [] map_height;
    player = {
      color = ANSITerminal.black;
      coords = 0,0;
      chunk_coords = map_width / 2, map_height / 2;
      character = 'i';
      inv = {
        sets = [];
        max_size = inventory_max_size};
      equipped_item = None;
    };
    mode = Base;
    default_block = default_block;
    game_is_paused = ref (false);
  } in
  {populated_map with player = {populated_map.player with
    coords = find_clear_coords (get_chunk_in_map populated_map (map_width / 2) (map_height / 2))}}
