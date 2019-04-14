open ANSITerminal

type block = {
  character : char;
  color : ANSITerminal.style;
  background_color : ANSITerminal.style;
  styles : ANSITerminal.style list;
  ground : bool;
  name : string;
}

let grass : block = {
  character = ' ';
  color = ANSITerminal.green;
  background_color = ANSITerminal.on_green;
  styles = [];
  ground = true;
  name = "grass";
}

let tree : block = {
  character = 'X';
  color = ANSITerminal.yellow;
  background_color = ANSITerminal.on_green;
  styles = [ANSITerminal.Bold];
  ground = false;
  name = "tree"
}

let water : block = {
  character = '~';
  color = ANSITerminal.white;
  background_color = ANSITerminal.on_blue;
  styles = [ANSITerminal.Blink];
  ground = false;
  name = "water"
}

let get_block_color b = b.color
let get_block_background_color b = b.background_color
let get_block_character b = b.character
let get_block_ground b = b.ground
let get_block_styles b = b.styles
