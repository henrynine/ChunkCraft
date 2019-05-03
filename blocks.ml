open ANSITerminal
open Items

type block = {
  character : char;
  color : ANSITerminal.style;
  background_color : ANSITerminal.style;
  styles : ANSITerminal.style list;
  ground : bool;
  name : string;
  max_items : int;
  sets : (Items.item * int) list;
  preferred_tools : Items.item list;
  action : block -> (Items.item * int) list -> int ->
           (block * ((Items.item * int) list));
  update : (block -> block) option
}

let grass : block = {
  character = ' ';
  color = ANSITerminal.black;
  background_color = ANSITerminal.on_green;
  styles = [ANSITerminal.Blink];
  ground = true;
  name = "grass";
  max_items = max_int;
  sets = [];
  preferred_tools = [];
  action = (fun b i m -> (b, i));
  update = None
}

let tree : block = {
  character = 'T';
  color = ANSITerminal.yellow;
  background_color = ANSITerminal.on_green;
  styles = [ANSITerminal.Bold];
  ground = false;
  name = "tree";
  max_items = 0;
  sets = [];
  preferred_tools = [Items.wood_axe; Items.stone_axe; Items.iron_axe];
  action = (fun b i m -> (b, i));
  update = None
}

let water : block = {
  character = '~';
  color = ANSITerminal.white;
  background_color = ANSITerminal.on_blue;
  styles = [ANSITerminal.Blink];
  ground = false;
  name = "water";
  max_items = 0;
  sets = [];
  preferred_tools = [];
  action = (fun b i m -> (b, i));
  update = None
}

let wood_plank : block = {
  character = ' ';
  color = ANSITerminal.black;
  background_color = Colors.on_brown;
  styles = [];
  ground = false;
  name = "wood plank";
  max_items = 0;
  sets = [];
  preferred_tools = [];
  action = (fun b i m -> (b, i));
  update = None
}

let stone : block = {
  character = ' ';
  color = ANSITerminal.black;
  background_color = Colors.on_gray;
  styles = [];
  ground = false;
  name = "stone";
  max_items = 0;
  sets = [];
  preferred_tools = [Items.wood_pick; Items.stone_pick; Items.iron_pick];
  action = (fun b i m -> (b, i));
  update = None
}

let cobblestone : block = {
  character = 'X';
  color = ANSITerminal.black;
  background_color = Colors.on_gray;
  styles = [];
  ground = false;
  name = "cobblestone";
  max_items = 0;
  sets = [];
  preferred_tools = [];
  action = (fun b i m -> (b, i));
  update = None
}

let rec closed_door : block = {
  character = 'X';
  color = ANSITerminal.black;
  background_color = Colors.on_brown;
  styles = [];
  ground = false;
  name = "closed door";
  max_items = 0;
  sets = [];
  preferred_tools = [];
  (* Hacky but works *)
  action = (fun b i m-> ({
    character = 'O';
    color = ANSITerminal.black;
    background_color = Colors.on_brown;
    styles = [];
    ground = true;
    name = "open door";
    max_items = 0;
    sets = [];
    preferred_tools = [];
    action = (fun b i m -> (closed_door, i));
    update = None
  }, i));
  update = None
}

let open_door : block = {
  character = 'O';
  color = ANSITerminal.black;
  background_color = Colors.on_brown;
  styles = [];
  ground = true;
  name = "open door";
  max_items = 0;
  sets = [];
  preferred_tools = [];
  action = (fun b i m -> (closed_door, i));
  update = None
}

let chest : block = {
  character = 'C';
  color = ANSITerminal.black;
  background_color = Colors.on_brown;
  styles = [];
  ground = false;
  name = "chest";
  max_items = 15;
  sets = [];
  preferred_tools = [];
  action = (fun b i m -> (b, i));
  update = None
}

let iron_ore : block = {
  character = '#';
  color = Colors.orange;
  background_color = Colors.on_gray;
  styles = [];
  ground = false;
  name = "iron ore";
  max_items = 0;
  sets = [];
  preferred_tools = [Items.stone_pick; Items.iron_pick];
  action = (fun b i m -> (b, i));
  update = None
}

let get_block_color b = b.color
let get_block_background_color b = b.background_color
let get_block_character b = if List.length b.sets = 0 || (not b.ground) then b.character else '*'
let get_block_name b = b.name
let get_block_ground b = b.ground
let get_block_styles b = b.styles
let get_preferred_tools b = b.preferred_tools
let get_block_action b = b.action
let get_block_update b = b.update

let confirm_furnace b =
  if b.name <> "furnace" then failwith "Not a furnace" else ()

let get_furnace_fuel b =
  confirm_furnace b;
  let potential_fuel = List.nth b.sets 0 in
  if snd potential_fuel <= 0 then None else Some potential_fuel

(* Add (item, count) to furnace fuel slot. If that items is already in the fuel
   slot, add on, else, if it is empty, add it, else, something else is already
   there, so fail. *)
let add_furnace_fuel b (item, count) =
  confirm_furnace b;
  let current_fuel = get_furnace_fuel b in
  match current_fuel with
  | Some (i, c) ->
      if Items.get_item_name i = Items.get_item_name item then
      {b with sets = Items.add_to_set_list_multiple item count b.sets}
      else failwith "Furnace already has a different fuel"
  | None -> {b with sets = (item, count)::(List.tl b.sets)}

(* Remove the fuel from b and put it in set_list if that doesn't make
   the list of set_list exceed max. Then return the new furnace and the new
   set list. *)
let remove_furnace_fuel b set_list max_size =
  confirm_furnace b;
  let current_fuel = get_furnace_fuel b in
  match current_fuel with
  | Some (i, c) ->
      let new_set_list = Items.add_to_set_list_multiple i c set_list in
      if List.length new_set_list > max_size then failwith "Set list is full"
      else
        let new_furnace = {b with sets = (Items.stick, 0)::(List.tl b.sets)} in
        (new_furnace, new_set_list)
  | None -> (b, set_list)


let get_furnace_input b =
  confirm_furnace b;
  let potential_input = List.nth b.sets 1 in
  if snd potential_input <= 0 then None else Some potential_input

let add_furnace_input b (item, count) =
  confirm_furnace b;
  let current_input = get_furnace_input b in
  match current_input with
  | Some (i, c) ->
      if Items.get_item_name i = Items.get_item_name item then
      {b with sets = Items.add_to_set_list_multiple item count b.sets}
      else failwith "Furnace already has a different input"
  | None ->
    {b with sets = (List.hd b.sets)::(item, count)::(List.tl b.sets |> List.tl)}

let remove_furnace_input b set_list max_size =
  confirm_furnace b;
  let current_input = get_furnace_input b in
  match current_input with
  | Some (i, c) ->
      let new_set_list = Items.add_to_set_list_multiple i c set_list in
      if List.length new_set_list > max_size then failwith "Set list is full"
      else
        let new_furnace =
          {b with sets =
            (List.hd b.sets)::(Items.stick, 0)::(List.tl b.sets |> List.tl)} in
        (new_furnace, new_set_list)
  | None -> (b, set_list)

let get_furnace_output b =
  confirm_furnace b;
  let potential_output = List.nth b.sets 2 in
  if snd potential_output <= 0 then None else Some potential_output

let remove_furnace_output b set_list max_size =
  confirm_furnace b;
  let current_output = get_furnace_output b in
  match current_output with
    | Some (i, c) ->
        let new_set_list = Items.add_to_set_list_multiple i c set_list in
        if List.length new_set_list > max_size then failwith "Set list is full"
        else
          let new_furnace =
            {b with sets =
              (List.hd b.sets)::(List.tl b.sets |> List.hd)::[(Items.stick, 0)]}
          in (new_furnace, new_set_list)
    | None -> (b, set_list)

let furnace_conversions = [
  (Items.pork_chop, Items.cooked_pork_chop);
  (Items.iron_ore, Items.iron)
]

(* Remove item from fuel and input if there is one and both and convert using
   table above to put in output *)
let update_furnace furnace =
  let input_item = get_furnace_input furnace in
  let current_output_item = (match get_furnace_output furnace with | None -> None | Some (i, c) -> Some i) in
  match input_item with
  | None -> furnace
  | Some (item, count) ->
    begin
      print_endline (Items.get_item_name item);
      let converted_item_opt = List.assoc_opt item furnace_conversions in
      let converted_item =
        (match converted_item_opt with
        | None -> failwith "no conversion for that item"
        | Some i -> i) in
      if (Items.item_in_set_list Items.log furnace.sets) &&
          (match current_output_item with | None -> true | Some i -> (Items.get_item_name i) = (Items.get_item_name converted_item)) then
      begin
        (* Smelt the item *)
        (*  og input is (item, count) *)
        let old_input = (item, count) in
        let old_fuel = List.nth furnace.sets 0 in
        let old_output = List.nth furnace.sets 2 in
        (*  It is guaranteed at this point that old output is either (_, 0) or (converted_item, x)*)
        let new_set_list = ((fst old_fuel), (snd old_fuel - 1))::(item, count - 1)::[((converted_item), (snd old_output) + 1)] in
        {furnace with sets = new_set_list}
      end
      else furnace
    end




(* Display functions – have to go here since they work closely with blocks *)

let press_n_to_continue () =
  print_endline "Press n to continue.";
  while (let c = input_char Pervasives.stdin in c <> 'n') do 1+1 done

let rec print_inv inventory_list =
  if List.length inventory_list = 0 then
    print_endline "Your inventory is empty."
  else
    List.iteri (fun i (item, count) -> print_endline
      (((Char.escaped (Char.chr (97 + i))) ^ " - ") ^
      (Items.get_item_name item) ^ ": " ^ (string_of_int count))) inventory_list

let rec show_furnace_interface furnace set_list max_size : (block * ((Items.item * int) list)) =
  (* Save current terminal size *)
  let original_width, original_height = ANSITerminal.size () in
  (* Resize terminal *)
  ANSITerminal.resize 80 24;
  ANSITerminal.erase ANSITerminal.Screen;
  ANSITerminal.set_cursor 1 1;
  let res : (block * ((Items.item * int) list)) = (
    (* Print current fuel, input, output *)
    let current_fuel = get_furnace_fuel furnace in
    (match current_fuel with
    | None -> print_endline "Current fuel: none"
    | Some (i, c) -> print_endline ("Current fuel: " ^ (Items.get_item_name i) ^ " x" ^ (string_of_int c)));
    let current_input = get_furnace_input furnace in
    (match current_input with
    | None -> print_endline "Current input: none"
    | Some (i, c) -> print_endline ("Current input: " ^ (Items.get_item_name i) ^ " x" ^ (string_of_int c)));
    let current_output = get_furnace_output furnace in
    (match current_output with
    | None -> print_endline "Current output: none"
    | Some (i, c) -> print_endline ("Current output: " ^ (Items.get_item_name i) ^ " x" ^ (string_of_int c)));
    print_endline "Press f to add or remove fuel, i to add or remove input, and o to collect \
                   \noutput. Press b to exit.";
    let inp = ref (input_char Pervasives.stdin) in
    (* NOTE: !c means the dereference of c;
        needed for reading mutable variables *)
    while ((!inp) <> 'f' && (!inp) <> 'i' && (!inp) <> 'o' && (!inp) <> 'b') do
      print_endline ((!inp) |> Char.escaped);
      ANSITerminal.move_bol();
      ANSITerminal.erase ANSITerminal.Eol;
      inp := (input_char Pervasives.stdin)
    done;
    if (!inp) = 'f' then
      begin
        ANSITerminal.set_cursor 1 1;
        ANSITerminal.erase ANSITerminal.Screen;
        (match current_fuel with
        | None -> print_endline "Current fuel: none"
        | Some (i, c) -> print_endline ("Current fuel: " ^ (Items.get_item_name i) ^ " x" ^ (string_of_int c)));
        print_endline "Press a to add fuel and r to remove the current fuel.";
        ANSITerminal.move_bol();
        ANSITerminal.erase ANSITerminal.Eol;
        while ((!inp) <> 'a' && (!inp) <> 'r') do
          print_endline ((!inp) |> Char.escaped);
          ANSITerminal.move_cursor 0 (-1);
          ANSITerminal.move_bol();
          ANSITerminal.erase ANSITerminal.Eol;
          inp := (input_char Pervasives.stdin)
        done;
        ANSITerminal.set_cursor 1 1;
        ANSITerminal.erase ANSITerminal.Screen;
        if ((!inp) = 'a') then
          try
            print_inv set_list;
            if List.length set_list = 0 then
              begin
                press_n_to_continue();
                show_furnace_interface furnace set_list max_size
              end
            else
              begin
                print_endline "Press the letter next to the item you want to put in as fuel.";
                inp := (input_char Pervasives.stdin);
                ANSITerminal.move_bol ();
                ANSITerminal.erase ANSITerminal.Eol;
                let index_pressed = (Char.code (!inp)) - 97 in
                if (index_pressed < List.length set_list && index_pressed >= 0) then
                    let (item, count) = List.nth set_list index_pressed in
                    if (Items.get_item_name item) <> "log" then
                      begin
                        ANSITerminal.set_cursor 1 1;
                        ANSITerminal.erase ANSITerminal.Screen;
                        print_endline "You can only use logs as fuel.";
                        press_n_to_continue ();
                        show_furnace_interface furnace set_list max_size
                      end
                    else
                      let new_furnace = add_furnace_fuel furnace (item, count) in
                      let new_set_list = Items.remove_from_set_list_multiple item count set_list in
                      (new_furnace, new_set_list)
                else
                  begin
                    ANSITerminal.erase ANSITerminal.Screen;
                    ANSITerminal.set_cursor 1 1;
                    print_endline "Please enter a valid letter.";
                    press_n_to_continue ();
                    show_furnace_interface furnace set_list max_size
                  end
              end
          with Failure("Furnace already has a different fuel") ->
            begin
              print_endline "The furnace already has a different fuel in it.";
              press_n_to_continue();
              show_furnace_interface furnace set_list max_size
            end
        else
          (* remove furnace fuel *)
          begin
            try
              remove_furnace_fuel furnace set_list max_size
            with Failure("Set list is full") ->
              begin
                ANSITerminal.erase ANSITerminal.Screen;
                ANSITerminal.set_cursor 1 1;
                print_endline "You have no room in your inventory.";
                press_n_to_continue ();
                show_furnace_interface furnace set_list max_size
              end
          end
      end
    else if (!inp) = 'i' then
    begin
      ANSITerminal.erase ANSITerminal.Screen;
      ANSITerminal.set_cursor 1 1;
      (match current_input with
      | None -> print_endline "Current input: none"
      | Some (i, c) -> print_endline ("Current input: " ^ (Items.get_item_name i) ^ " x" ^ (string_of_int c)));
      print_endline "Press a to add input and r to remove the current input.";
      ANSITerminal.move_bol();
      ANSITerminal.erase ANSITerminal.Eol;
      while ((!inp) <> 'a' && (!inp) <> 'r') do
        print_endline ((!inp) |> Char.escaped);
        ANSITerminal.move_cursor 0 (-1);
        ANSITerminal.move_bol();
        ANSITerminal.erase ANSITerminal.Eol;
        inp := (input_char Pervasives.stdin)
      done;
      ANSITerminal.set_cursor 1 1;
      ANSITerminal.erase ANSITerminal.Screen;
      if (!inp) = 'a' then
        begin
        try
          print_inv set_list;
          if List.length set_list = 0 then
            begin
              press_n_to_continue();
              show_furnace_interface furnace set_list max_size
            end
          else
            begin
              print_endline "Press the letter next to the item you want to put in as input.";
              inp := (input_char Pervasives.stdin);
              let index_pressed = (Char.code (!inp)) - 97 in
              if (index_pressed < List.length set_list && index_pressed >= 0) then
                  let (item, count) = List.nth set_list index_pressed in
                  if (Items.get_item_name item) <> "pork chop" && (Items.get_item_name item) <> "iron ore" then
                    begin
                      ANSITerminal.set_cursor 1 1;
                      ANSITerminal.erase ANSITerminal.Screen;
                      print_endline "You can only use pork chops or iron ore as input.";
                      press_n_to_continue ();
                      show_furnace_interface furnace set_list max_size
                    end
                  else
                    let new_furnace = add_furnace_input furnace (item, count) in
                    let new_set_list = Items.remove_from_set_list_multiple item count set_list in
                    (new_furnace, new_set_list)
              else
                begin
                  ANSITerminal.erase ANSITerminal.Screen;
                  ANSITerminal.set_cursor 1 1;
                  print_endline "Please enter a valid letter.";
                  press_n_to_continue ();
                  show_furnace_interface furnace set_list max_size
                end
            end
        with Failure("Furnace already has a different input") ->
          begin
            print_endline "The furnace already has a different input in it.";
            press_n_to_continue();
            show_furnace_interface furnace set_list max_size
          end
        end
      else
        (* remove furnace input *)
        try
          remove_furnace_input furnace set_list max_size
        with Failure("Set list is full") ->
          begin
            ANSITerminal.erase ANSITerminal.Screen;
            ANSITerminal.set_cursor 1 1;
            print_endline "You have no room in your inventory.";
            press_n_to_continue ();
            show_furnace_interface furnace set_list max_size
          end
    end
    else if (!inp) = 'o' then
      try
        remove_furnace_output furnace set_list max_size
      with Failure("Set list is full") ->
        begin
          ANSITerminal.erase ANSITerminal.Screen;
          ANSITerminal.set_cursor 1 1;
          print_endline "You have no room in your inventory.";
          press_n_to_continue ();
          show_furnace_interface furnace set_list max_size
        end
    else
      (* exit *)
      (furnace, set_list)
  ) in
  ANSITerminal.resize original_width original_height;
  ANSITerminal.erase ANSITerminal.Screen;
  res


(* End display functions) *)

let furnace : block = {
  character = 'F';
  color = ANSITerminal.black;
  background_color = Colors.on_gray;
  styles = [];
  ground = false;
  name = "furnace";
  max_items = 3;
  sets = [(Items.stick, 0); (Items.stick, 0); (Items.stick, 0)];
  preferred_tools = [];
  action = show_furnace_interface;
  update = Some update_furnace
}


let add_item_to_block i b : block =
  if (List.length b.sets) >= b.max_items then failwith "Block is full"
  else {b with sets = Items.add_to_set_list i b.sets}

let add_item_to_block_multiple i c b =
  if (List.length b.sets) >= b.max_items then failwith "Block is full"
  else {b with sets = Items.add_to_set_list_multiple i c b.sets}

let remove_item_from_block_multiple i c b : block =
  if (List.length b.sets) = 0 then failwith "Block has no items"
  else {b with sets = Items.remove_from_set_list_multiple i c b.sets}

let count_sets_in_block b = List.length b.sets

let sets_in_block b = b.sets

let take_first_item (b : block) : (block * Items.item * int) =
  if List.length (b.sets) = 0 then failwith "No items in block"
  else let i, c = (List.nth b.sets 0) in
  ((remove_item_from_block_multiple i c b), i, c)
