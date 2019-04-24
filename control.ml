open State
open Display
open ANSITerminal

let handle_command map command =
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
    State.pause map;
    let res = Display.show_inventory map in
    State.unpause map;
    res;
  | 'm' ->
    State.set_to_mining_mode map
  | 'p' ->
    State.set_to_placing_mode map
  | 'c' ->
    State.pause map;
    let res = Display.show_crafting_interface map in
    State.unpause map;
    res;
  | 'e' ->
    State.set_to_interacting_mode map
  | _ -> failwith "Unknown command"
