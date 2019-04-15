open ANSITerminal
open Blocks
open Item

(* Types *)

type chunk = {
  blocks : Blocks.block list list;
  coords : int * int
}

type inventory = {
  sets : (Item.item * int) list;
  max_size : int
}

type player = {
  color : ANSITerminal.style;
  coords : int * int;
  chunk_coords : int * int;
  character : char;
  inv : inventory
}

type map = {
  chunks : chunk list list;
  player : player
}

(* End Types *)


(* Constants *)
let inventory_max_size () = 10
(* End Constants *)


(* Helpers *)

let empty_inventory () = {
  sets = [];
  max_size = inventory_max_size ()
}

let get_player_chunk_coords m = m.player.chunk_coords

let get_player_coords m = m.player.coords

let get_chunks m = m.chunks

let get_blocks c = c.blocks

let get_player_color m = m.player.color

let get_player_character m = m.player.character

let get_player_inventory m = m.player.inv

let get_chunk_size c = (List.length (List.hd c.blocks)), (List.length c.blocks)

let get_chunk_size_x c = get_chunk_size c |> fst

let get_chunk_size_y c = get_chunk_size c |> snd

let get_inventory_max_size i = i.max_size

let get_inventory_size i = List.length (i.sets)

let item_in_inventory i p = List.fold_left (fun acc s -> (Item.get_item_name i) = (Item.get_item_name (fst s)) || acc) false p.inv.sets

let get_inventory_sets i = i.sets

(* Assumes all chunks are the same height *)
let get_chunk_height m = (List.length (List.hd m.chunks))

(* End Helpers *)

(* player with item added to inventory or incremented, depending on which
   is appropriate *)
let add_to_inventory (i : Item.item) (p : player) : player =
  (* check if there is room in the player's inventory *)
  if (get_inventory_size p.inv) >= (get_inventory_max_size p.inv)
  then failwith "Inventory is full"
  else
  (* Add item to inventory if it is not already present, otherwise increment
     that item's count *)
  if item_in_inventory i p then
  (* Item isn't present yet, add it with a count of 1 *)
  {p with
    inv = {p.inv with
             sets = ((i, 1)::(p.inv.sets))}
  } else
  (* Item is already present, increment the count in the player's inventory *)
  {p with
    inv = {p.inv with sets = (List.map (fun (n, c) -> if ((Item.get_item_name n) = (Item.get_item_name i)) then (n, c+1) else (n, c)) (p.inv.sets))}
  }

(* Player with: decrement count of item in player's inventory, if the count is then zero,
   remove it from the item *)
let remove_from_inventory (i: Item.item) (p:player) =
  if item_in_inventory i p then
  (* increment count*)
  {p with
     inv = {p.inv with sets =
       ((List.map (fun (n, c) -> if (Item.get_item_name n = Item.get_item_name i) then
        (n, c - 1) else (n, c))
        p.inv.sets) |> List.filter (fun (n, c) -> c > 0))
     }
   }
   else
   (* if count of an item is zero, throw an error – there is nothing to
       remove *)
    failwith ("That item isn't in that character's inventory")



let move_player m c : map =
  let (player_x, player_y) = m.player.coords in
  let (player_chunk_x, player_chunk_y) = m.player.chunk_coords in
  let move_tuple =
    begin
      match c with
        | 'a' -> (-1, 0)
        | 'w' -> (0, -1)
        | 'd' -> (1 , 0)
        | 's' -> (0 , 1)
        | _ -> (0 , 0)
    end
    in
  (* Calculate the coorinates of the move if it is in the same chunk as before *)
  let (new_coords_x, new_coords_y) =
    begin
      match move_tuple with
        | x, y -> player_x + x, player_y + y
        | _ -> player_x, player_y
    end
    in
  (* Grab the current chunk object *)
  let current_chunk = List.nth (List.nth m.chunks player_chunk_y) player_chunk_x in
  (* Calculate the coordinates of the new chunk on the chunk grid.
     Also, if the player moves chunks, then change their coords correspondingly.
     *)
  let ((new_chunk_x, new_chunk_y), (final_coords_x, final_coords_y)) =
    begin
      match (new_coords_x, new_coords_y) with
        | x, y when x >= get_chunk_size_x current_chunk -> (player_chunk_x + 1, player_chunk_y), (0, y)
        | x, y when y >= get_chunk_size_y current_chunk -> (player_chunk_x, player_chunk_y + 1), (x, 0)
        | x, y when x < 0 -> (player_chunk_x - 1, player_chunk_y), ((get_chunk_size_x current_chunk) - 1 , y)
        | x, y when y < 0 -> (player_chunk_x, player_chunk_y - 1), (x, (get_chunk_size_y current_chunk) - 1)
        | x, y -> (player_chunk_x , player_chunk_y), (x, y)
    end
    in
  (* Check if the new chunk coordinates are valid *)
  if new_chunk_x < 0 || new_chunk_x >= (List.length (List.hd m.chunks)) then m
  else if new_chunk_y < 0 || new_chunk_y >= (List.length m.chunks) then m
  else
  (* Set the new chunk *)
  let new_chunk = List.nth (List.nth m.chunks new_chunk_y) new_chunk_x in
  let next_block = List.nth (List.nth new_chunk.blocks final_coords_y) final_coords_x in
  if Blocks.get_block_ground next_block then
  {m with player = {m.player with coords = (final_coords_x, final_coords_y); chunk_coords = (new_chunk_x, new_chunk_y)}}
  else m
