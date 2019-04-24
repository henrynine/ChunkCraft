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
  loot : unit -> (Items.item * int)
}

val pig : entity

val get_color : entity -> ANSITerminal.style

val get_character : entity -> char

val get_health : entity -> int

val get_loot : entity -> (Items.item * int)
