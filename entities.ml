open Colors
open Items

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

let pig = {
  name = "pig";
  character = "P";
  color = Colors.pink;
  health = 10;
  attack = None;
  loot = [(Items.pork_chop, 2)]
}
