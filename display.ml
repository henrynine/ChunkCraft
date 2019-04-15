open ANSITerminal
open State

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

let print_inventory map =
  (* clear the screen *)
  ANSITerminal.erase ANSITerminal.Screen;
  (* Set the cursor in the bottom left *)
  ANSITerminal.set_cursor 1 1;
  (* Print inventory in form of "item_name: count" *)
  let rec print_inv = function
    | [] -> ()
    | (i, c)::t -> begin print_endline ((Item.get_item_name i) ^ ": " ^ (string_of_int c)); print_inv t end
  in print_inv ((State.get_player_inventory map) |> State.get_inventory_sets);
  print_endline "Press e to exit inventory"
