type item = {
  name : string;
  stackable : bool;
  (* item list is what's needed to craft, int is how many you get *)
  recipe : ((item * int) list * int) option;
  preferred_multiplier : int
}

(** The item for a log. *)
val log : item
(** The item for a wood plank. *)
val wood_plank : item
(** The item for a stick. *)
val stick : item
(** The item for a wood pick. *)
val wood_pick : item
(** The item for a wood shovel. *)
val wood_shovel : item
(** The item for a wood sword. *)
val wood_sword : item
(** The item for a wood axe. *)
val wood_axe : item
(** The item for stone. *)
val stone : item
(** The item for a stone pick. *)
val stone_pick : item
(** The item for a stone shovel. *)
val stone_shovel : item
(** The item for a stone sword. *)
val stone_sword : item
(** The item for a stone axe. *)
val stone_axe : item

(** A list of all items. *)
val all_items : item list

(** Get the name of [i]. *)
val get_item_name : item -> string

(** Check if [i] is stackable. *)
val get_item_stackable : item -> bool

(** Get the preferred multiplier for [i]. *)
val get_preferred_multiplier : item -> int

(** Get the full recipe for crafting [i]. *)
val get_full_recipe : item -> ((item * int) list * int) option

(** Check how many copies of [i] you get when you craft it. *)
val get_craft_count : item -> int option

(** Check if [i] is in [l]. *)
val item_in_set_list : item -> (item * int) list -> bool

(** Get how many copies of [i] are in [l]. *)
val get_count_in_set_list : item -> (item * int) list -> int

(** Return [l] with one copy of [i] added. *)
val add_to_set_list : item -> (item * int) list -> (item * int) list

(** Return [l] with one copy of [i] removed. *)
val remove_from_set_list : item -> (item * int) list -> (item * int) list

(** Return [l] with [c] copies of [i] added. *)
val add_to_set_list_multiple :
  item -> int -> (item * int) list -> (item * int) list

(** Return [l] with [c] copies of [i] removed. *)
val remove_from_set_list_multiple :
  item -> int -> (item * int) list -> (item * int) list
