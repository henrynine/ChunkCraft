open State
open Display
open ANSITerminal

let handle_command map command =
  match command with
  | 'w' | 'a' | 's' | 'd' when not (in_mining_mode map || in_placement_mode map) ->
    State.move_player map command
  | 'w' | 'a' | 's' | 'd' when in_mining_mode map ->
    State.mine map command
  | 'w' | 'a' | 's' | 'd' when in_placement_mode map ->
    State.place map command
  | 'i' -> Display.show_inventory map
  | 'm' ->
    State.toggle_mining_mode map
  | 'p' ->
    State.toggle_placement_mode map
  | 'c' -> Display.show_crafting_interface map
  | _ -> failwith "Unknown command"
