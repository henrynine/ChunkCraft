open State
open Display
open ANSITerminal

let handle_command map command =
  match command with
  | 'w' | 'a' | 's' | 'd' when (get_map_mode map) = State.Base ->
    State.move_player map command
  | 'w' | 'a' | 's' | 'd' when (get_map_mode map) = State.Mining ->
    State.mine map command
  | 'w' | 'a' | 's' | 'd' when (get_map_mode map) = State.Placing ->
    State.place map command
  | 'i' -> Display.show_inventory map
  | 'm' ->
    State.set_to_mining_mode map
  | 'p' ->
    State.set_to_placing_mode map
  | 'c' -> Display.show_crafting_interface map
  | _ -> failwith "Unknown command"
