open ANSITerminal
open Blocks

type chunk = {
  blocks : Blocks.block list list;
  coords : int * int
}

type player = {
  color : ANSITerminal.style;
  coords : int * int;
  chunk_coords : int * int;
  character : char
}

type map = {
  chunks : chunk list list;
  player : player
}

val get_player_chunk_coords : map -> int * int

val get_player_coords : map -> int * int

val get_chunks : map -> chunk list list

val get_blocks : chunk -> Blocks.block list list

val get_player_color : map -> ANSITerminal.style

val get_player_character : map -> char

val move_player : map -> char -> map

val get_chunk_size : chunk -> int * int

val get_chunk_size_x : chunk -> int

val get_chunk_size_y : chunk -> int 
