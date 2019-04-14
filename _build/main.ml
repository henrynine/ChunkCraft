open State
open Blocks
open Display
open ANSITerminal
open Control
open Unix

let player : State.player = {
  color = ANSITerminal.black;
  coords = 0, 0;
  chunk_coords = 0, 0;
  character = 'i';
}

let map : State.map = {
  chunks = [[{
    blocks = [
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    ];
    coords = 0, 0;
  };
  {
    blocks = [
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
  ];
  coords = 1,0;
  }
  ];
  [{
    blocks = [
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.tree; Blocks.tree; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    ];
    coords = 0,1;
  };
  {
    blocks = [
    [Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree; Blocks.tree;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.water; Blocks.water; Blocks.water; Blocks.water; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    [Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass; Blocks.grass;];
    ];
    coords = 1,1;
  }
  ]];
  player = player;
}

let _ =
  Unix.tcsetattr Unix.stdin Unix.TCSAFLUSH {(Unix.tcgetattr Unix.stdin) with c_icanon = false};
  ANSITerminal.erase ANSITerminal.Screen;
  Display.print_current_chunk map;
  let rec main_loop map =
    let c = input_char Pervasives.stdin in
    try
      let map = Control.handle_command map c in
      Display.print_current_chunk map;
      main_loop map
    with Failure("Unknown command") ->
      (* Display.print_current_chunk map; *)
      Display.print_current_chunk map;
      print_endline "Unknown command";
      main_loop map in
  main_loop map
