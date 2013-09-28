class Tile{
  int x, y;
  int f, g, h;
  Tile parent;
  int closed_id, open_id;
  boolean walkable;
  Tile(int x, int y) {
    this.x = x;
    this.y = y;
    walkable = true;
    closed_id = open_id = 0;
    f = g = h = 0;
  }
  // Calculate F
  // All calculation is inlined to increase speed
  void setF(Tile fin){
    // set g - goal value, how far we have travelled
    int xd = x - parent.x;
    int yd = y - parent.y;
    // Manhattan distance measuring - Math.abs inlined for speed
    g = parent.g + (xd < 0 ? -xd : xd) + (yd < 0 ? -yd : yd);
    // set h - heuristic, how far the target is
    xd = x - fin.x;
    yd = y - fin.y;
    h = (xd < 0 ? -xd : xd) + (yd < 0 ? -yd : yd);
    // therefore f equals:
    f = g + h;
  }
  // Called at the beginning of the search to initialise the the start square as farthest
  void setH(Tile fin){
    // Manhattan distance measuring - Math.abs inlined for speed
    int xd = x - fin.x;
    int yd = y - fin.y;
    h = (xd < 0 ? -xd : xd) + (yd < 0 ? -yd : yd);
  }
}
