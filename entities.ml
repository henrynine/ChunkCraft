open Colors
open Items
open QCheck

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

let pig = {
  name = "pig";
  character = 'P';
  color = Colors.pink;
  health = 10;
  attack = None;
  loot = (fun () -> (Items.pork_chop, 2));
  update = (fun (e, (x, y)) ->
             let d = (Random.int 2) in
             let adjust =
               (Random.int 3) - 1 in
             let new_x, new_y =
               x + (if d = 1 then adjust else 0), y + (if d = 1 then 0 else adjust) in
             (e, (new_x, new_y)))
            (* Randomly move 1 direction in x or y if that stays in chunk *);
}

let get_color e = e.color

let get_character e = e.character

let get_health e = e.health

let get_loot e = e.loot ()

let get_update e = e.update
