// A* pathfinding for tile sliding game

// This is a heavily optimised A* routine.

// A* usually requires a list of open and a list of closed nodes to identify which nodes to search through
// This requires heavy searching through arrays that can be avoided by tagging each floor tile
// with an "open" or "closed" marker. To avoid having to reset all of these markers, we can create
// a special number for each search and tag the floor tiles' closed and open markers with that
// number.

// More speed and intelligence is gained through setting the closest_good_node during the search
// This ensures that the AI moves into a good position if the finish node can't be reached

// A* will search the entire map if allowed to, which causes a judder when looking for complex paths
// this is solved below by limiting the search_steps (normally a while loop is used) cropping the
// intelligence enough to keep a decent overhead

import java.util.ArrayList;

class AStar{
  int search_id = 0;
  ArrayList open;
  Tile adjacent_tile;
  int search_steps = 2000;
  int map_width, map_height;
  Tile [][] tile_map;

  AStar(Tile [][] tile_map){
    this.tile_map = tile_map;
    map_height = tile_map.length;
    map_width = tile_map[0].length;
  }
  // Returns an Array of Nodes defining the shortest distance between x0,y0 & x1,y1
  // Note that the A* map is a scale version of your game map - it locates the grid
  // node in a linear array.
  ArrayList getPath(Tile start, Tile finish){
    search_id++;
    if (start == finish || !finish.walkable || start == null || finish == null) {
      return new ArrayList();
    }
    start.setH(finish);
    open = new ArrayList();
    open.add(start);
    boolean found = false;
    Tile closest_good_node = start;
    for(int k = 0; k < search_steps; k++){
      if(open.size() == 0) break;
      int lowest = Integer.MAX_VALUE;
      int c = -1;
      for (int i = 0; i < open.size(); i++) {
        Tile temp = (Tile)open.get(i);
        if (temp.f < lowest) {
          lowest = temp.f;
          c = i;
        }
      }
      Tile current = (Tile)open.remove(c);
      // At this juncture we set an alternative finish point that is closest to the target
      // this makes for a predictive AI
      if(current.h < closest_good_node.h) closest_good_node = current;
      current.closed_id = search_id;
      current.open_id = 0;
      if (current == finish) {
        found = true;
        break;
      }
      // Check all directions
      // UP
      if(current.y > 0){
        adjacent_tile = tile_map[current.y-1][current.x];
        if (adjacent_tile.walkable && adjacent_tile.closed_id != search_id) {
          if (adjacent_tile.open_id != search_id) {
            open.add(adjacent_tile);
            adjacent_tile.open_id = search_id;
            adjacent_tile.closed_id = 0;
            adjacent_tile.parent = current;
            adjacent_tile.setF(finish);
          } 
          else {
            if (adjacent_tile.g > current.g + 1){
              adjacent_tile.parent = current;
              adjacent_tile.setF(finish);
            }
          }
        }
      }
      // RIGHT
      if(current.x < map_width-1){
        adjacent_tile = tile_map[current.y][current.x+1];
        if (adjacent_tile.walkable && adjacent_tile.closed_id != search_id) {
          if (adjacent_tile.open_id != search_id) {
            open.add(adjacent_tile);
            adjacent_tile.open_id = search_id;
            adjacent_tile.closed_id = 0;
            adjacent_tile.parent = current;
            adjacent_tile.setF(finish);
          } 
          else {
            if (adjacent_tile.g > current.g + 1){
              adjacent_tile.parent = current;
              adjacent_tile.setF(finish);
            }
          }
        }
      }
      // DOWN
      if(current.y < map_height-1){
        adjacent_tile = tile_map[current.y+1][current.x];
        if (adjacent_tile.walkable && adjacent_tile.closed_id != search_id) {
          if (adjacent_tile.open_id != search_id) {
            open.add(adjacent_tile);
            adjacent_tile.open_id = search_id;
            adjacent_tile.closed_id = 0;
            adjacent_tile.parent = current;
            adjacent_tile.setF(finish);
          } 
          else {
            if (adjacent_tile.g > current.g + 1){
              adjacent_tile.parent = current;
              adjacent_tile.setF(finish);
            }
          }
        }
      }
      // LEFT
      if(current.x > 0){
        adjacent_tile = tile_map[current.y][current.x-1];
        if (adjacent_tile.walkable && adjacent_tile.closed_id != search_id) {
          if (adjacent_tile.open_id != search_id) {
            open.add(adjacent_tile);
            adjacent_tile.open_id = search_id;
            adjacent_tile.closed_id = 0;
            adjacent_tile.parent = current;
            adjacent_tile.setF(finish);
          } 
          else {
            if (adjacent_tile.g > current.g + 1){
              adjacent_tile.parent = current;
              adjacent_tile.setF(finish);
            }
          }
        }
      }
    }
    ArrayList path = new ArrayList();
    Tile path_node = finish;
    if(!found) path_node = closest_good_node;
    for(int k = 0; k < 1000;k++){
      if(path_node == start) break;
      path.add(path_node);
      path_node = path_node.parent;
    }
    return path;
  }
}
