type item = {
  name : string;
  stackable : bool;
  (* item list is what's needed to craft, int is how many you get *)
  recipe : ((item * int) list * int) option
}

val log : item
val wood_plank : item
val stick : item

val all_items : item list

val get_item_name : item -> string

val get_item_stackable : item -> bool

val get_full_recipe : item -> ((item * int) list * int) option

val get_craft_count : item -> int option

val item_in_set_list : item -> (item * int) list -> bool

val get_count_in_set_list : item -> (item * int) list -> int

val add_to_set_list : item -> (item * int) list -> (item * int) list

val remove_from_set_list : item -> (item * int) list -> (item * int) list

val add_to_set_list_multiple : item -> int -> (item * int) list -> (item * int) list

val remove_from_set_list_multiple : item -> int -> (item * int) list -> (item * int) list
