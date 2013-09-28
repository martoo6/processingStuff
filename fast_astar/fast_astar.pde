Tile [][] tile_map;
AStar astar;

void setup(){
  size(400, 400);
  tile_map = new Tile[40][40];
  astar = new AStar(tile_map);
  initMap();
  frameRate(25);
}
void draw(){
  background(145);
  scale(10);
  drawTiles();
  ArrayList path = astar.getPath(tile_map[0][0], tile_map[(int)(mouseY/10)][(int)(mouseX/10)]);
  stroke(255,0,0);
  for(int i = 0; i < path.size(); i++){
    Tile temp = (Tile)path.get(i);
    point(temp.x, temp.y);
  }
  stroke(0);
  point(0,0);
  point(mouseX/10, mouseY/10);
}
void mousePressed(){
  initMap();
}
void drawTiles(){
  stroke(240);
  for(int r = 0; r < tile_map.length; r++){
    for(int c = 0; c < tile_map[r].length; c++){
      if(tile_map[r][c].walkable){
        point(c, r);
      }
    }
  }
}
void initMap(){
  for(int r = 0; r < tile_map.length; r++){
    for(int c = 0; c < tile_map[r].length; c++){
      tile_map[r][c] = new Tile(c, r);
      if(random(1) > 0.7 && c + r > 3){
        tile_map[r][c].walkable = false;
      } else {
        tile_map[r][c].walkable = true;
      }
    }
  }
}
