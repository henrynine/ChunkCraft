open State
open Display
open ANSITerminal

let handle_command map command game_is_paused =
  match command with
  | 'w' | 'a' | 's' | 'd' when (get_map_mode map) = State.Base ->
    State.move_player map command
  | 'w' | 'a' | 's' | 'd' when (get_map_mode map) = State.Mining ->
    State.mine map command
  | 'w' | 'a' | 's' | 'd' when (get_map_mode map) = State.Placing ->
    State.place map command
  | 'i' ->
    game_is_paused := true;
    let res = Display.show_inventory map in
    game_is_paused := false;
    res;
  | 'm' ->
    State.set_to_mining_mode map
  | 'p' ->
    State.set_to_placing_mode map
  | 'c' ->
    game_is_paused := true;
    let res = Display.show_crafting_interface map in
    game_is_paused := false;
    res;
  | _ -> failwith "Unknown command"
