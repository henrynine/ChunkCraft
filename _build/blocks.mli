open ANSITerminal

type block = {
  character : char;
  color : ANSITerminal.style;
  background_color : ANSITerminal.style;
  styles : ANSITerminal.style list;
  ground : bool;
  name : string;
}

val grass : block
val tree : block
val water : block

val get_block_color : block -> ANSITerminal.style
val get_block_background_color : block -> ANSITerminal.style
val get_block_character : block -> char
val get_block_ground : block -> bool
val get_block_styles : block -> ANSITerminal.style list
