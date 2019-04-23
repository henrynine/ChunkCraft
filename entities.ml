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
  attack : attack option
}

let pig = {
  name = "pig";
  character = "P";
  color = Colors.pink;
  health = 10;
  attack = None
}
