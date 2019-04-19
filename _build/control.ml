open State
open Display
open ANSITerminal

let handle_command map command =
  match command with
  | 'w' | 'a' | 's' | 'd' when not (in_mining_mode map) ->
    State.move_player map command
  | 'w' | 'a' | 's' | 'd' when in_mining_mode map ->
    State.mine map command
  | 'i' -> Display.show_inventory map
  | 'm' ->
    (* Toggle mining mode *)
    {map with mining = (not map.mining)}
  | 'p' ->
    (* Toggle placement mode *)
    {map with placement = (not map.placement)}
  | 'c' -> Display.show_crafting_interface map
  | _ -> failwith "Unknown command"
