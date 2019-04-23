open State
open Display
open ANSITerminal

let handle_command map command game_is_paused =
  match command with
  | 'w' | 'a' | 's' | 'd' ->
    begin
    match (get_map_mode map) with
    | State.Base -> State.move_player map command
    | State.Mining -> State.mine map command
    | State.Placing -> State.place map command
    | State.Interacting -> State.interact map command
    end
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
  | 'e' ->
    State.set_to_interacting_mode map
  | _ -> failwith "Unknown command"
