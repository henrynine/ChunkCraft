open Blocks
open OUnit2
open State
open Items
open ANSITerminal

let player : State.player = {
  color = ANSITerminal.black;
  coords = 0, 0;
  chunk_coords = 0, 0;
  character = 'i';
  inv = {
    sets = [];
    max_size = State.inventory_max_size};
  equipped_item = None
}

let inventory_with_3_wood_planks = {
  sets = [(Items.wood_plank, 3)];
  max_size = State.inventory_max_size
}

let set_of_3_wood_planks = [(Items.wood_plank, 3)]

let player_with_wood_plank : State.player = {
  color = ANSITerminal.black;
  coords = 0, 0;
  chunk_coords = 0, 0;
  character = 'i';
  inv = inventory_with_3_wood_planks;
  equipped_item = None;
}

let player_with_log_equipped : State.player = {
  color = ANSITerminal.black;
  coords = 0, 0;
  chunk_coords = 0, 0;
  character = 'i';
  inv = inventory_with_3_wood_planks;
  equipped_item = Some (Items.log, 1);
}

let player_with_wood_plank_and_log : State.player = {
  color = ANSITerminal.black;
  coords = 0, 0;
  chunk_coords = 0, 0;
  character = 'i';
  inv = {inventory_with_3_wood_planks with sets =
    ((Items.log, 1)::inventory_with_3_wood_planks.sets)};
  equipped_item = None;
}

let inventory1 = {
  sets = [];
  max_size = State.inventory_max_size
}

let inventory_full = {
  sets = [(Items.wood_plank, 3);(Items.wood_plank, 3);(Items.wood_plank, 3);
    (Items.wood_plank, 3);(Items.wood_plank, 3);(Items.wood_plank, 3);
    (Items.wood_plank, 3);(Items.wood_plank, 3);(Items.wood_plank, 3);
    (Items.wood_plank, 3)];
  max_size = State.inventory_max_size
}

let player_post_right_move : State.player = {
  color = ANSITerminal.black;
  coords = 1, 0;
  chunk_coords = 0, 0;
  character = 'i';
  inv = {
    sets = [];
    max_size = State.inventory_max_size};
  equipped_item = None;
}

let player_post_down_move = {
  player_post_right_move with coords = 0,1
}

let player_post_down_up_move = {player_post_right_move with coords = 0,0}

let player_post_right_left_move = {player_post_right_move with coords = 0,0}

let blocks1 : Blocks.block list list = [
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; {Blocks.grass with sets = Items.add_to_set_list Items.log (Items.add_to_set_list Items.log (Items.add_to_set_list Items.log Blocks.grass.sets))}; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  ]

let chunks1 : State.chunk list list =
  [
    [
      {
        blocks = [
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; {Blocks.grass with sets = Items.add_to_set_list Items.log (Items.add_to_set_list Items.log (Items.add_to_set_list Items.log Blocks.grass.sets))}; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
          [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        ];
      coords = 0, 0;
      };
     {
       blocks = [
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       ];
       coords = 1,0;
     }
  ];
 [{
     blocks = [
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
     ];
     coords = 0,1;
   };
    {
      blocks = [
        [Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      ];
      coords = 1,1;
    }
  ]
 ]

 let chunk_with_new_tree_block : State.chunk= {
   blocks = [
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; {Blocks.grass with sets = Items.add_to_set_list Items.log (Items.add_to_set_list Items.log (Items.add_to_set_list Items.log Blocks.grass.sets))}; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
   ];
   coords = 0, 0;
 }

let chunks_with_chunk_with_new_tree_block = [
    [
      chunk_with_new_tree_block;
     {
       blocks = [
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
         [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       ];
       coords = 1,0;
     }
  ];
  [{
     blocks = [
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
       [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
     ];
     coords = 0,1;
   };
    {
      blocks = [
        [Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
        [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      ];
      coords = 1,1;
    }
  ]
]

let map : State.map = {
    chunks = [[{
      blocks = [
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; {Blocks.grass with sets = Items.add_to_set_list Items.log (Items.add_to_set_list Items.log (Items.add_to_set_list Items.log Blocks.grass.sets))}; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      ];
      coords = 0, 0;
    };
    {
      blocks = [
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    ];
    coords = 1,0;
    }
    ];
    [{
      blocks = [
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      ];
      coords = 0,1;
    };
    {
      blocks = [
      [Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      ];
      coords = 1,1;
    }
    ]];
    player = player;
    mining = false;
  }

let map_with_item_below = {
    chunks = [[{
      blocks = [
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [{Blocks.grass with sets = Items.add_to_set_list Items.log (Items.add_to_set_list Items.log (Items.add_to_set_list Items.log Blocks.grass.sets))}; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      ];
      coords = 0, 0;
    };
    {
      blocks = [
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    ];
    coords = 1,0;
    }
    ];
    [{
      blocks = [
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      ];
      coords = 0,1;
    };
    {
      blocks = [
      [Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      ];
      coords = 1,1;
    }
    ]];
    player = player;
    mining = false;
  }

let player_with_three_logs =
  {player with inv = {player.inv with sets = [(Items.log, 3)]}; coords = 0,1}

let map_post_pickup = {map with player = player_with_three_logs}

let map_pre_chunk_move = {map with player =
  {map.player with coords = 0,23;chunk_coords=0,0}}
(* Move down *)
let map_post_chunk_move = {map with player =
  {map.player with coords = 0,0;chunk_coords=0,1} }


let map_post_right_move : State.map = {
  chunks = [[{
    blocks = [
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; {Blocks.grass with sets = Items.add_to_set_list Items.log (Items.add_to_set_list Items.log (Items.add_to_set_list Items.log Blocks.grass.sets))}; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
      ];
    coords = 0, 0;
  };
  {
    blocks = [
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  ];
  coords = 1,0;
  }
  ];
  [{
    blocks = [
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    ];
    coords = 0,1;
  };
  {
    blocks = [
    [Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.tree;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    ];
    coords = 1,1;
  }
  ]];
  player = player_post_right_move;
  mining = false;
}

let map_post_down_move =
  {map_post_right_move with player = player_post_down_move}
let map_post_down_up_move =
  {map_post_right_move with player = player_post_down_up_move}
let map_post_left_right_move =
  {map_post_right_move with player = player_post_right_left_move}


(* Blocks testing*)
let first_chunk = (List.nth (List.nth map.chunks 0) 0)
let first_block = (List.nth (List.nth first_chunk.blocks 0) 0)
let first_block_with_log : block = {
  character = ' ';
  color = ANSITerminal.black;
  background_color = ANSITerminal.on_green;
  styles = [ANSITerminal.Blink];
  ground = true;
  name = "grass";
  max_items = max_int;
  sets = [(Items.log, 1)]
}
let first_block_with_2_items : block = {
  character = ' ';
  color = ANSITerminal.black;
  background_color = ANSITerminal.on_green;
  styles = [ANSITerminal.Blink];
  ground = true;
  name = "grass";
  max_items = max_int;
  sets = [(Items.wood_sword, 1); (Items.log, 1)]
}
let first_block_with_sword : block = {
  character = ' ';
  color = ANSITerminal.black;
  background_color = ANSITerminal.on_green;
  styles = [ANSITerminal.Blink];
  ground = true;
  name = "grass";
  max_items = max_int;
  sets = [(Items.wood_sword, 1)]
}
let tree_block = (List.nth (List.nth first_chunk.blocks 8) 3)
let three_planks_and_two_logs = [(Items.wood_plank, 3); (Items.log, 2)]

let all_tests = "All tests" >::: [

(* State testing *)

"test get_player_chunk_coords" >::
  (fun _ -> assert_equal (State.get_player_chunk_coords map) (0,0));
"test get_player_coords" >::
  (fun _ -> assert_equal (State.get_player_coords map) (0,0));
"test get_chunks" >::
  (fun _ -> assert_equal (State.get_chunks map) (chunks1));
"test get_blocks" >::
  (fun _ -> assert_equal
    (State.get_blocks (List.nth (List.nth (State.get_chunks map) 0) 0))
      (blocks1));
"test get_player_color" >::
  (fun _ -> assert_equal (State.get_player_color map) (ANSITerminal.black));
"test get_player_character" >::
  (fun _ -> assert_equal (State.get_player_character map) ('i'));
"test move_player right" >::
  (fun _ -> assert_equal (State.move_player map 'd') (map_post_right_move));
"test move_player down" >::
  (fun _ -> assert_equal (State.move_player map 's') (map_post_down_move));
"test move_player down up" >::
  (fun _ -> assert_equal (State.move_player (State.move_player map 's') 'w')
    (map_post_down_up_move));
"test move_player right left" >::
  (fun _ -> assert_equal (State.move_player (State.move_player map 'd') 'a')
    (map_post_left_right_move));
"test move across chunk" >::
  (fun _ -> assert_equal (State.move_player map_pre_chunk_move 's')
    map_post_chunk_move);
"test get_player_inventory" >::
  (fun _ -> assert_equal (State.get_player_inventory map) (inventory1));
"test get_chunk_size" >::
  (fun _ -> assert_equal (State.get_chunk_size
    (List.nth (List.nth (State.get_chunks map) 0) 0)) (24,24));
"test get_chunk_size_x" >::
  (fun _ -> assert_equal (State.get_chunk_size_x
    (List.nth (List.nth (State.get_chunks map) 0) 0)) (24));
"test get_chunk_size_y" >::
  (fun _ -> assert_equal (State.get_chunk_size_y
    (List.nth (List.nth (State.get_chunks map) 0) 0)) (24));
"test get_inventory_max_size" >::
  (fun _ -> assert_equal (State.get_inventory_max_size inventory1) (10));
"test get_inventory_size" >::
  (fun _ -> assert_equal
    (State.get_inventory_size inventory_with_3_wood_planks) (1));
"test item_in_inventory" >::
  (fun _ -> assert_equal
    (State.item_in_inventory Items.wood_plank player_with_wood_plank) (true));
"test item_in_inventory on non-present item" >::
  (fun _ -> assert_equal
    (State.item_in_inventory Items.wood_pick player_with_wood_plank) false);
"test count_of_item_in_inv" >::
  (fun _ -> assert_equal
    (State.count_of_item_in_inv Items.wood_plank player_with_wood_plank) 3);
"test count_of_item_in_inv on non-present item" >::
  (fun _ -> assert_equal
    (State.count_of_item_in_inv Items.wood_pick player_with_wood_plank) 0);
"test in_mining_mode" >::
  (fun _ -> assert_equal (State.in_mining_mode map) false);
"test inventory_is_full" >::
  (fun _ -> assert_equal
    (State.inventory_is_full player_with_wood_plank) false);
"test inventory_is_full_map" >::
  (fun _ -> assert_equal (State.inventory_is_full_map map) false);
"test replace_block_in_chunk" >::
  (fun _ -> assert_equal (State.replace_block_in_chunk map tree_block 0 0 4 8)
    chunk_with_new_tree_block);
"test replace_chunk_in_chunks" >::
  (fun _ -> assert_equal
    (State.replace_chunk_in_chunks map chunk_with_new_tree_block 0 0)
      chunks_with_chunk_with_new_tree_block);
"test inventory_is_full_map" >::
  (fun _ -> assert_equal
    (State.inventory_is_full_map {map with player =
      {player with inv = inventory_full}}) (true));
"test get_chunk_height" >::
  (fun _ -> assert_equal (State.get_chunk_height map) (24));
"test add_to_inventory" >::
  (fun _ -> assert_equal (State.add_to_inventory Items.wood_plank player)
    (State.remove_from_inventory_multiple Items.wood_plank 2 player_with_wood_plank));
"test add_to_inventory_multiple" >::
  (fun _ -> assert_equal
    (State.add_to_inventory_multiple Items.wood_plank 2 player)
      (State.remove_from_inventory Items.wood_plank player_with_wood_plank));
"test equip_item" >::
  (fun _ -> assert_equal
    (State.equip_item Items.log 1 {map with player =
      player_with_wood_plank_and_log}) (player_with_log_equipped));
"test unequip_item" >::
  (fun _ -> assert_equal (State.unequip_item {map with player =
    player_with_log_equipped}) ({map with player =
      player_with_wood_plank_and_log}));
"test has_item_equipped" >::
(fun _ -> assert_equal
  (State.has_item_equipped {map with player = player_with_log_equipped}) true);
"test equipped_item" >::
  (fun _ -> assert_equal
    (State.equipped_item {map with player = player_with_log_equipped})
      (Some (Items.log, 1)));
"test get_current_chunk" >::
  (fun _ -> assert_equal (State.get_current_chunk map) (first_chunk));
"test get_inventory_sets" >::
  (fun _ -> assert_equal (State.get_inventory_sets inventory_with_3_wood_planks)
    (set_of_3_wood_planks));
(* "test picking up items by walking over" *)
(* NOTE fix the bug for picking up multiple items in a block *)
"test pickup" >:: (fun _ ->
   assert_equal (State.move_player map_with_item_below 's') map_post_pickup);




(* Blocks testing*)

"test get_block_color" >::
  (fun _ -> assert_equal (Blocks.get_block_color first_block)
    (ANSITerminal.black));
"test get_block_background_color" >::
  (fun _ -> assert_equal (Blocks.get_block_background_color first_block)
    (ANSITerminal.on_green));
"test get_block_character" >::
  (fun _ -> assert_equal (Blocks.get_block_character first_block) (' '));
"test get_block_ground" >::
  (fun _ -> assert_equal (Blocks.get_block_ground first_block) (true));
"test get_block_styles" >::
  (fun _ -> assert_equal (Blocks.get_block_styles first_block)
    ([ANSITerminal.Blink]));
"test add_item_to_block" >::
  (fun _ -> assert_equal (first_block_with_log)
    (Blocks.add_item_to_block Items.log first_block));
"test remove_item_from_block" >::
  (fun _ -> assert_equal (first_block)
    (Blocks.remove_item_from_block_multiple Items.log 1 first_block_with_log));
"test count_sets_in_block" >::
  (fun _ -> assert_equal (1) (Blocks.count_sets_in_block first_block_with_log));
"test sets_in_block" >::
  (fun _ -> assert_equal
    (Blocks.sets_in_block first_block_with_log) ([(Items.log, 1)]));
"test take_first_item" >::
  (fun _ -> assert_equal (Blocks.take_first_item first_block_with_2_items)
    ((first_block_with_log, Items.wood_sword, 1)));
"test add_item_to_block_fail" >::
    (fun _ -> assert_raises (Failure "Block is full")
        (fun () -> Blocks.add_item_to_block Items.wood_sword tree_block));
"test remove_item_from_block_fail" >::
    (fun _ -> assert_raises (Failure "Block has no items")
      (fun () -> Blocks.remove_item_from_block_multiple Items.wood_sword 1 first_block));
"test take_first_item_fail" >::
    (fun _ -> assert_raises (Failure "No items in block")
        (fun () -> Blocks.take_first_item first_block));

(* Item testing*)

"test get_item_stackable" >::
  (fun _ -> assert_equal (Items.get_item_stackable Items.log) (true));
"test get_full_recipe" >::
  (fun _ -> assert_equal (Items.get_full_recipe Items.log) (None));
"test get_full_recipe_some" >::
  (fun _ -> assert_equal (Items.get_full_recipe Items.wood_plank)
    (Some ([(log, 1)], 4)));
"test get_craft_count" >::
  (fun _ -> assert_equal (Items.get_craft_count Items.wood_plank) (Some 4));
"test get_craft_count_none" >::
  (fun _ -> assert_equal (Items.get_craft_count Items.log) (None));
"test get_count_in_set_list" >::
  (fun _ -> assert_equal
    (Items.get_count_in_set_list Items.log three_planks_and_two_logs) 2);
"test get_count_in_set_list" >::
  (fun _ -> assert_equal
    (Items.get_count_in_set_list Items.wood_sword three_planks_and_two_logs) 0);
"test add_to_set_list_multiple_there" >::
  (fun _ -> assert_equal
    (add_to_set_list_multiple Items.log 1 three_planks_and_two_logs)
      ([(Items.wood_plank, 3); (Items.log, 3)]));
"test add_to_set_list_multiple_not_there" >::
  (fun _ -> assert_equal
    (add_to_set_list_multiple Items.wood_sword 1 three_planks_and_two_logs)
      ([(Items.wood_sword, 1); (Items.wood_plank, 3); (Items.log, 2)]));
"test remove_from_set_list_multiple" >::
  (fun _ -> assert_equal
    (remove_from_set_list_multiple Items.log 1 three_planks_and_two_logs)
      ([(Items.wood_plank, 3); (Items.log, 1)]));

]

let _ = run_test_tt_main all_tests
