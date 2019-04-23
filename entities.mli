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
  loot : (Items.item * int) list option
}

val pig : entity
