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
  loot : unit -> (Items.item * int)
}

let pig = {
  name = "pig";
  character = 'P';
  color = Colors.pink;
  health = 10;
  attack = None;
  loot = fun () -> Items.pork_chop, 2
}

let get_color e = e.color

let get_character e = e.character

let get_health e = e.health

let get_loot e = e.loot ()
