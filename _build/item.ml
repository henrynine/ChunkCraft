type item = {
  name : string;
  stackable : bool
}

let wood_plank : item = {
  name = "wood plank";
  stackable = true
}

let stick : item = {
  name = "stick";
  stackable = true
}

let get_item_name i = i.name

let get_item_stackable i = i.stackable
