open State
open Items

(** Print the current chunk in [map]. *)
val print_current_chunk : State.map -> unit

(** Open the inventory interface for [map]. *)
val show_inventory : State.map -> map

(** Open the crafting interface for [map]. *)
val show_crafting_interface : State.map -> State.map

val print_splash_screen: unit -> unit
