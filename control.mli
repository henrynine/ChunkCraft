open State
(** Handle [command]. *)
val handle_command : State.map -> char -> bool ref -> State.map
