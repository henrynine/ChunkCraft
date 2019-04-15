type item = {
  name : string;
  stackable : bool;
}

val wood_plank : item
val stick : item

val get_item_name : item -> string

val get_item_stackable : item -> bool
