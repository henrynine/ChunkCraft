open State
open Display
open ANSITerminal

let handle_command map command =
  match command with
  | 'w' | 'a' | 's' | 'd' -> State.move_player map command
  | 'i' ->
    begin
    Display.print_inventory map;
    (* wait for escape key -> Unix should already be grabbing keys originally *)
    while (let c = input_char Pervasives.stdin in c <> 'e') do
      1+1
    done;
    (* This helps get rid of the weird extraneous 'y' bug *)
    ANSITerminal.erase ANSITerminal.Screen;
    map
    end
  | _ -> failwith "Unknown command"
