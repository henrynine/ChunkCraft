open State
open Blocks
open Display
open ANSITerminal
open Control
open Unix
open Items

exception Update of State.map

let _ =
  (* Set stdin to not wait for a newline to read input *)
  Unix.tcsetattr Unix.stdin Unix.TCSAFLUSH {(Unix.tcgetattr Unix.stdin)
    with c_icanon = false};
  (* Clear the screen *)
  ANSITerminal.erase ANSITerminal.Screen;
  ANSITerminal.resize 110 9;
  Display.print_splash_screen ();
  (* Randomly generate the map *)
  Random.self_init ();
  let map = State.generate_map (Random.int 1000000) Blocks.grass in
  (* Resize the terminal to fit the chunk size *)
  ANSITerminal.resize (State.get_chunk_width map) (State.get_chunk_height map + 3);
  (* Print out the starting chunk *)
  Display.print_current_chunk map;
  let rec main_loop map =
    try
      (* Set what to do when the timer goes off*)
      ignore (Sys.signal
        Sys.sigalrm
        (Sys.Signal_handle (fun _ -> if (State.is_paused map) then () else raise(Update (State.update_non_player_actions map)))));
      let c = input_char Pervasives.stdin in
      try
        let map = Control.handle_command map c in
        Display.print_current_chunk map;
        main_loop map
      with Failure("Unknown command") ->
        (* Display.print_current_chunk map; *)
        Display.print_current_chunk map;
        print_endline "Unknown command";
        main_loop map
    with Update new_map ->
      Display.print_current_chunk new_map;
      main_loop new_map in
  let timer : Unix.interval_timer = Unix.ITIMER_REAL in
  let initial_status : Unix.interval_timer_status =
    {
      it_interval = 0.5;
      it_value = 0.5;
    } in
  let start = Unix.setitimer timer initial_status in
  main_loop map
