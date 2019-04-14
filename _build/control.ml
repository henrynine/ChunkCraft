open State

let handle_command map command =
  match command with
  | 'w' | 'a' | 's' | 'd' -> State.move_player map command
  | _ -> failwith "Unknown command"
