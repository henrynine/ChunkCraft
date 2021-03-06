open ANSITerminal
open State
open Items
open Unix
open Blocks

let press_n_to_continue () =
  print_endline "Press n to continue.";
  while (let c = input_char Pervasives.stdin in c <> 'n') do 1+1 done

let print_splash_screen () =
  ANSITerminal.set_cursor 1 1;
  ANSITerminal.(print_string [] "
 ______     __  __     __  __     __   __     __  __        ______     ______     ______     ______   ______
/\\  ___\\   /\\ \\_\\ \\   /\\ \\/\\ \\   /\\ \"-.\\ \\   /\\ \\/ /       /\\  ___\\   /\\  == \\   /\\  __ \\   /\\  ___\\ /\\__  _\\
\\ \\ \\____  \\ \\  __ \\  \\ \\ \\_\\ \\  \\ \\ \\-.  \\  \\ \\  _\"-.     \\ \\ \\____  \\ \\  __<   \\ \\  __ \\  \\ \\  __\\ \\/_/\\ \\/
 \\ \\_____\\  \\ \\_\\ \\_\\  \\ \\_____\\  \\ \\_\\ \"\\_\\  \\ \\_\\ \\_\\     \\ \\_____\\  \\ \\_\\ \\_\\  \\ \\_\\ \\_\\  \\ \\_\\      \\ \\_\\
  \\/_____\\/  \\/_/\\/_/   \\/_____/   \\/_/ \\/_/   \\/_/\\/_/      \\/_____/   \\/_/ /_/   \\/_/\\/_/   \\/_/       \\/_/

");
  press_n_to_continue ()

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
                    (State.get_blocks current_chunk);
                    (* Print equipped item *)

                    ANSITerminal.erase ANSITerminal.Eol;
                    match State.equipped_item map with
                    | None -> print_endline "No item equipped."
                    | Some (i, c) -> print_endline ("Equipped: "
                     ^ (Items.get_item_name i) ^ " ("
                     ^ (string_of_int c) ^ ")");
                    ANSITerminal.erase ANSITerminal.Eol;
                    match State.get_map_mode map with
                    | State.Base -> ()
                    | State.Mining -> print_endline "In mining mode."
                    | State.Placing -> print_endline "In placing mode."
                    | State.Interacting -> print_endline "In interacting mode."
                    in
  let print_player =
    (* ANSITerminal is 1-indexed *)
    ANSITerminal.set_cursor (player_x + 1) (player_y + 1);
    ANSITerminal.(print_string
                  (ANSITerminal.Bold::[State.get_player_color map;
                   Blocks.get_block_background_color current_block])
                  (Char.escaped (State.get_player_character map))) in
  let print_entities =
    List.iter (fun (e, coords) ->
                (* ANSITerminal is 1-indexed *)
                ANSITerminal.set_cursor ((fst coords)+1) ((snd coords) + 1);
                ANSITerminal.(print_string
                 ((Entities.get_color e)::[State.get_default_block map |> Blocks.get_block_background_color])
                 (Char.escaped (Entities.get_character e)))) (State.get_entities current_chunk) in
  print_chunk;
  print_player;
  print_entities;

  let adjustment = match State.get_map_mode map with
                   | State.Base -> 0
                   | State.Mining -> 1
                   | State.Placing -> 1
                   | State.Interacting -> 1 in

  ANSITerminal.set_cursor 1 ((State.get_chunk_size_y current_chunk)+3+adjustment);
  ANSITerminal.erase ANSITerminal.Eol;
  ANSITerminal.set_cursor 1 ((State.get_chunk_size_y current_chunk)+2+adjustment);
  ANSITerminal.erase ANSITerminal.Eol

let rec print_inv is_dropping inventory_list =
  if List.length inventory_list = 0 then
    print_endline "Your inventory is empty."
  else
    List.iteri (fun i (item, count) -> print_endline ((if is_dropping then
      (Char.escaped (Char.chr (97 + i))) ^ " - " else "") ^
      (Items.get_item_name item) ^ ": " ^ (string_of_int count))) inventory_list

let rec show_inventory map =
  (* Save current terminal size *)
  let original_width, original_height = ANSITerminal.size () in
  (* Resize terminal *)
  ANSITerminal.resize 80 24;
  let res =
  (* clear the screen *)
  (ANSITerminal.erase ANSITerminal.Screen;
  (* Set the cursor in the bottom left *)
  ANSITerminal.set_cursor 1 1;
  (* Print inventory in form of "item_name: count" *)
  print_inv false ((State.get_player_inventory map)
                    |> State.get_inventory_sets);
  print_endline "Press e to equip items.\n\
                 Press d to drop items.\n\
                 Press u to unequip your current equipped item.\n\
                 Press b to exit inventory.";
  (* wait for escape key ('b') -> Unix should already be grabbing
    keys originally *)
  let c = ref (input_char Pervasives.stdin) in
  (* NOTE: !c means the dereference of c;
      needed for reading mutable variables *)
  while ((!c) <> 'b' && (!c) <> 'd' && (!c) <> 'e' && (!c) <> 'u') do
    print_endline ((!c) |> Char.escaped);
    ANSITerminal.move_cursor 0 (-1);
    ANSITerminal.move_bol();
    ANSITerminal.erase ANSITerminal.Eol;
    c := (input_char Pervasives.stdin)
  done;
  if ((!c) = 'u') then
    begin
      if State.inventory_is_full_map map then
      begin
        print_endline "Your inventory is full. Drop an item to make room
          to unequip.";
        show_inventory map
      end
      else
      begin
        if State.has_item_equipped map then
          State.unequip_item map
        else
          begin
            ANSITerminal.set_cursor 1 1;
            ANSITerminal.erase ANSITerminal.Screen;
            print_endline "You don't have an item equipped.";
            press_n_to_continue ();
            show_inventory map
          end
      end
    end
  else if ((!c) = 'e') then
    begin
      ANSITerminal.erase ANSITerminal.Screen;
      ANSITerminal.set_cursor 1 1;
      let inventory_list = (State.get_player_inventory map)
                            |> State.get_inventory_sets in
      print_inv true inventory_list;
      if List.length inventory_list > 0 then
      begin
        print_endline "Enter the letter next to the items you want to equip.";
        c := (input_char Pervasives.stdin);
        let index_pressed = (Char.code (!c)) - 97 in
        if (index_pressed < List.length inventory_list && index_pressed >= 0) then
          begin
            let (item, count) = List.nth inventory_list index_pressed in
            {map with player = State.equip_item item count map}
          end
        else
          begin
            ANSITerminal.erase ANSITerminal.Screen;
            ANSITerminal.set_cursor 1 1;
            print_endline "Please enter a valid letter.";
            press_n_to_continue ();
            show_inventory map
          end
        end
        else
          begin
          press_n_to_continue();
          show_inventory map
          end
      end



  else if ((!c) = 'd')
    then
    begin
      ANSITerminal.erase ANSITerminal.Screen;
      ANSITerminal.set_cursor 1 1;
      let inventory_list = (State.get_player_inventory map)
                            |> State.get_inventory_sets in
      print_inv true inventory_list;
      if List.length inventory_list > 0 then
        begin
        print_endline "Enter the letter next to the items you want to drop.";
        c := (input_char Pervasives.stdin);
        let index_pressed = (Char.code (!c)) - 97 in
        if (index_pressed < List.length inventory_list && index_pressed >= 0)
          then
            begin
              let (item, count) = List.nth inventory_list index_pressed in
              State.drop_item item count map
            end
          else
            begin
            ANSITerminal.erase ANSITerminal.Screen;
            ANSITerminal.set_cursor 1 1;
            print_endline "Please enter a valid letter.";
            press_n_to_continue ();
            show_inventory map
            end
        end
      else
        begin
        press_n_to_continue();
        show_inventory map
        end
    end
    else map) in
  (* put the screen back *)
  ANSITerminal.resize original_width original_height;
  ANSITerminal.erase ANSITerminal.Screen;
  res



let rec show_crafting_interface map =
  (* Save current terminal size *)
  let original_width, original_height = ANSITerminal.size () in
  (* Resize terminal *)
  ANSITerminal.resize 80 24;
  let res = (ANSITerminal.erase ANSITerminal.Screen;
  ANSITerminal.set_cursor 1 1;
  print_inv false ((State.get_player_inventory map) |> State.get_inventory_sets);
  print_endline "Enter what you want to craft. Enter all to see all the items you can craft\n\
                 with your current items or enter b to exit: ";
  (* Turn wait for endline to get input back on *)
  Unix.tcsetattr Unix.stdin Unix.TCSAFLUSH {(Unix.tcgetattr Unix.stdin) with
                                                            c_icanon = true};
  let desired_item_name = input_line Pervasives.stdin in
  Unix.tcsetattr Unix.stdin Unix.TCSAFLUSH {(Unix.tcgetattr Unix.stdin) with
                                                            c_icanon = false};
  ANSITerminal.erase ANSITerminal.Screen;
  ANSITerminal.set_cursor 1 1;
  if desired_item_name = "b" then map
  else
  if desired_item_name = "all" then
  begin
  (* List all items that can be crafted with the items in inventory *)
  (* go through Items.all_items, call State.player_has_enough_items on that item's recipe*)
  let craftable_items =
    List.filter
      (fun i ->
        match Items.get_full_recipe i with
        | None -> false
        | Some (recipe, _) -> State.player_has_enough_items map recipe)
      Items.all_items in
  if List.length craftable_items = 0 then
    print_endline "You can't craft anything with your current inventory."
  else
   begin
    print_endline
      "With what you currently have in your inventory, you can craft:";
    List.iter (fun i -> print_endline (Items.get_item_name i)) craftable_items
   end;
  press_n_to_continue ();
  show_crafting_interface map
  end
  else
  (* Search for all items to find recipe for that item *)
  let desired_item = List.find_opt (fun i -> Items.get_item_name i =
                                    desired_item_name) Items.all_items in
  match desired_item with
  | None ->
      begin
      print_endline "That is not an item you can craft.";
      press_n_to_continue ();
      show_crafting_interface map
      end
  | Some i ->
    begin
    match Items.get_full_recipe i with
    | None ->
        begin
        print_endline "That is not an item you can craft.";
        press_n_to_continue ();
        show_crafting_interface map
        end
    | Some (recipe, output_count) ->
      (* check if player has r in inventory, if they don't, say that,
        otherwise craft it *)
      begin
        if not (State.player_has_enough_items map recipe) then
        begin
          print_endline "You don't have enough of the required materials to craft that.";
          print_endline "To craft that, you would need:";
          State.sets_needed_to_craft map recipe |>
          List.iter (fun (i', c) -> print_endline((Items.get_item_name i') ^ " x" ^ (string_of_int c)));
          press_n_to_continue ();
          show_crafting_interface map
        end
        else
        begin
        if output_count = 1 then
        print_endline ("You crafted a " ^ desired_item_name ^ ".")
        else
        print_endline ("You crafted " ^ (string_of_int output_count) ^ " "
                       ^ desired_item_name ^ "s.");
        press_n_to_continue ();
        (* remove the recipe items from player inventory,
          add the crafted item to their inventory *)
        {map with player = {map.player with inv = {map.player.inv with sets =
          (List.fold_left (fun acc (i', c) ->
            Items.remove_from_set_list_multiple i' c acc)
            map.player.inv.sets recipe)
          |> Items.add_to_set_list_multiple i output_count}}}
        end
      end
    end) in
  (* put the screen back *)
  ANSITerminal.resize original_width original_height;
  ANSITerminal.erase ANSITerminal.Screen;
  res
