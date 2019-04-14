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

let get_player_chunk_coords m = m.player.chunk_coords

let get_player_coords m = m.player.coords

let get_chunks m = m.chunks

let get_blocks c = c.blocks

let get_player_color m = m.player.color

let get_player_character m = m.player.character

let get_chunk_size c = (List.length (List.hd c.blocks)), (List.length c.blocks)

let get_chunk_size_x c = get_chunk_size c |> fst

let get_chunk_size_y c = get_chunk_size c |> snd

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
  if new_chunk_x < 0 || new_chunk_x > (List.length (List.hd m.chunks)) then m
  else if new_chunk_y < 0 || new_chunk_y > (List.length m.chunks) then m
  else
  (* Set the new chunk *)
  let new_chunk = List.nth (List.nth m.chunks new_chunk_y) new_chunk_x in
  let next_block = List.nth (List.nth new_chunk.blocks final_coords_y) final_coords_x in
  if Blocks.get_block_ground next_block then
  {m with player = {m.player with coords = (final_coords_x, final_coords_y); chunk_coords = (new_chunk_x, new_chunk_y)}}
  else m
