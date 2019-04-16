open ANSITerminal
open State
open Items
open Unix

let print_current_chunk map =
  (* put the cursor in the upper left corner *)
  ANSITerminal.set_cursor 1 1;
  let (player_chunk_x, player_chunk_y) = State.get_player_chunk_coords map in
  let (player_x, player_y) = State.get_player_coords map in
  let current_chunk = List.nth (List.nth (State.get_chunks map) player_chunk_y)
                               player_chunk_x in
  let current_block = List.nth (List.nth (State.get_blocks current_chunk)
                               player_y) player_x in
  (* print each row – before printing a block, check to see if the cursor is
     at the current player coords. if so, print the player display character
     with the background color of the block they are standing on. *)
  let print_chunk = List.iter (fun row ->
                    List.iter (fun block ->
                    ANSITerminal.(print_string
                                  ([Blocks.get_block_color block;
                                    Blocks.get_block_background_color block]
                                   @ (Blocks.get_block_styles block))
                                  (Char.escaped
                                   (Blocks.get_block_character block)))) row;
                               print_endline "")
                    (State.get_blocks current_chunk) in
  let print_player =
    (* ANSITerminal is 1-indexed *)
    ANSITerminal.set_cursor (player_x + 1) (player_y + 1);
    ANSITerminal.(print_string
                  (ANSITerminal.Bold::[State.get_player_color map;
                   Blocks.get_block_background_color current_block])
                  (Char.escaped (State.get_player_character map))) in
  print_chunk;
  print_player;

  ANSITerminal.set_cursor 1 ((State.get_chunk_size_y current_chunk)+2);
  ANSITerminal.erase ANSITerminal.Eol;
  ANSITerminal.set_cursor 1 ((State.get_chunk_size_y current_chunk)+1);
  ANSITerminal.erase ANSITerminal.Eol

let rec print_inv is_dropping inventory_list=
  List.iteri (fun i (item, count) -> print_endline ((if is_dropping then (Char.escaped (Char.chr (97 + i))) ^ " - " else "") ^ (Items.get_item_name item) ^ ": " ^ (string_of_int count))) inventory_list

let show_inventory map =
  (* clear the screen *)
  ANSITerminal.erase ANSITerminal.Screen;
  (* Set the cursor in the bottom left *)
  ANSITerminal.set_cursor 1 1;
  (* Print inventory in form of "item_name: count" *)
  print_inv false ((State.get_player_inventory map) |> State.get_inventory_sets);
  print_endline "Press b to exit inventory. Press d to drop items";
  (* wait for escape key ('b') -> Unix should already be grabbing keys originally *)
  let c = ref (input_char Pervasives.stdin) in
  while ((!c) <> 'd' || (!c) = 'b') do (* NOTE: !c means the dereference of c; needed for reading mutable variables *)
    print_endline ((!c) |> Char.escaped);
    ANSITerminal.move_bol();
    ANSITerminal.erase ANSITerminal.Eol;
    c := (input_char Pervasives.stdin)
  done;
  if ((!c) = 'd')
    then
    begin
      ANSITerminal.erase ANSITerminal.Screen;
      ANSITerminal.set_cursor 1 1;
      let inventory_list = (State.get_player_inventory map) |> State.get_inventory_sets in
      print_inv true inventory_list;
      c := (input_char Pervasives.stdin);
      let index_pressed = (Char.code (!c)) - 97 in
      if (index_pressed < List.length inventory_list)
        then
          begin
            let (item, count) = List.nth inventory_list index_pressed in
            let new_inventory = Items.remove_from_set_list_multiple item count inventory_list in
            let (player_x, player_y) = State.get_player_coords map in
            let (player_chunk_x, player_chunk_y) = State.get_player_chunk_coords map in
            let new_block = State.get_block_in_chunk map (State.get_current_chunk map) player_x player_y in
            let new_chunk = State.replace_block_in_chunk map {new_block with sets = [(item, count)]} player_chunk_x player_chunk_y player_x player_y in
            (* This helps get rid of the weird extraneous 'y' bug *)
            ANSITerminal.erase ANSITerminal.Screen;
            {map with player = {map.player with inv = {map.player.inv with sets = new_inventory}}; chunks = (State.replace_chunk_in_chunks map new_chunk player_chunk_x player_chunk_y)}
          end
        else
          (* print_endline "Please enter a valid letter."; *)
          (* This helps get rid of the weird extraneous 'y' bug *)
          begin
            ANSITerminal.erase ANSITerminal.Screen;
            map
          end
    end
    else
    begin
      (* This helps get rid of the weird extraneous 'y' bug *)
      ANSITerminal.erase ANSITerminal.Screen;
      map
    end



let rec show_crafting_interface map = failwith "unimplemented"
  (* ANSITerminal.erase ANSITerminal.Screen;
  ANSITerminal.set_cursor 1 1;
  print_inv false ((State.get_player_inventory map) |> State.get_inventory_sets);
  print_endline "Enter what you want to craft or b to exit: ";
  (* Turn wait for endline to get input back on *)
  Unix.tcsetattr Unix.stdin Unix.TCSAFLUSH {(Unix.tcgetattr Unix.stdin) with c_icanon = true};
  let desired_item_name = input_line Pervasives.stdin in
  Unix.tcsetattr Unix.stdin Unix.TCSAFLUSH {(Unix.tcgetattr Unix.stdin) with c_icanon = false};
  ANSITerminal.erase ANSITerminal.Screen;
  ANSITerminal.set_cursor 1 1;
  if desired_item_name = "b" then map else
  (* Search for all items to find recipe for that item *)
  let desired_item = List.find_opt (fun i -> Items.get_item_name i = desired_item_name) Items.all_items in
  match desired_item with
  | None ->
      begin
      print_endline "That is not an item you can craft. Press n to continue";
      while (let c = input_char Pervasives.stdin in c <> 'n') do 1+1 done;
      show_crafting_interface map
      end
  | Some i ->
    begin
    match Items.get_recipe i with
    | None ->
        begin
        print_endline "That is not an item you can craft. Press n to continue";
        while (let c = input_char Pervasives.stdin in c <> 'n') do 1+1 done;
        show_crafting_interface map
        end
    | Some (recipe, output_count) -> (* check if player has r in inventory, if they don't, say that, otherwise craft it *)
      begin
        let player_has_enough_items = List.fold_left (fun acc (i', c) ->
        (if c >= Item.get_count_in_set_list i' recipe then true else false) && acc
        (* if c >= count of same item as i in recipe, then true, if i' is not in recipe then true, otherwise false *)) true (State.get_player_inventory m) in
        if not player_has_enough_items then
        begin
        print_endline "You don't have enough of the required materials to craft that."; (* TODO tell the player how many more of each item they need *)
        show_crafting_interface map
        end
        else
        (* remove the recipe items from player inventory, add the crafted item to their inventory *)
        failwith "you crafted that successfully"
        (* {map with
          player = } *)
      end
    end;
  map *)
