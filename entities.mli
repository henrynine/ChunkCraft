open ANSITerminal
open Colors

type attack = {
  damage : int;
  range : int;
}

type entity = {
  name : string;
  character : char;
  color : ANSITerminal.style;
  health : int;
  attack : attack option;
  loot : unit -> (Items.item * int);
  update : (entity * (int * int)) -> (entity * (int * int))
}

val pig : entity

(** Get the color of [e]. *)
val get_color : entity -> ANSITerminal.style

(** Get the character used to represent [e]. *)
val get_character : entity -> char

(** Get the health of [e]. *)
val get_health : entity -> int

(** Get the loot from killing [e]. *)
val get_loot : entity -> (Items.item * int)

(** Get the action for updating [e]. *)
val get_update: entity -> (entity * (int * int)) -> (entity * (int * int))
