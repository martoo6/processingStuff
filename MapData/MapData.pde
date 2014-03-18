PImage img;
final int zoom=400;
ArrayList<Location> locations = new ArrayList<Location>();

//Limite Inferior -34.687428, -58.485432
//Limite superior -34.534844, -58.464146

//Limite izq -34.615692, -58.531094
//Limite derecho -34.626993, -58.335743

float topLimit=-34.687428; 
float bottomLimit=-34.534844;
float rightLimit=-58.335743;
float leftLimit=-58.531094;


void setup() {
  size(1280, 720, P3D);
  img = loadImage("map.png");
  img.resize(1500,1500);
  noStroke();
  String[] s = loadStrings("librerias.csv");
  for(String ss:s) {
    String[] tokens = splitTokens(ss,",\"");
    
    try{
      Location loc = new Location(tokens[0], Float.parseFloat(tokens[2]), Float.parseFloat(tokens[3])); //<>//
      if(loc.pos.x<=rightLimit && loc.pos.x>=leftLimit && loc.pos.y<=bottomLimit && loc.pos.y>=topLimit) locations.add(loc);
    }catch(NumberFormatException ex){
      //Do nothing..
    }
    
  }
}

void draw() {
  background(0);
  
  pushMatrix();
  translate(width / 2 - zoom/2, height *0.75,  -zoom/2);
  rotateY(frameCount*0.01);
  noStroke();
  beginShape();
  texture(img);
  
  vertex(-zoom, 0, -zoom, 0, 0);
  vertex(zoom, 0, -zoom, img.width, 0);
  vertex(zoom,0, zoom,  img.width, img.height);
  vertex(-zoom,0, zoom, 0, img.height);

  endShape();
  
  popMatrix();
  
  pushMatrix();
  
  
  translate(width / 2 - zoom/2, height *0.75,  -zoom/2);
  rotateY(frameCount*0.01);
  
  for(Location l :locations) l.render();
  
  popMatrix();
}

class Location{
  PVector pos;
  String desc;
  
  Location(String _desc, float coordS, float coordW){
    pos = new PVector(coordW, coordS);
    desc = _desc;
  }
  
  void render(){
    float x= map(pos.x, leftLimit, rightLimit, -zoom, zoom);
    float z = map(pos.y, bottomLimit, topLimit, -zoom, zoom);
    pushMatrix();
    translate(x, 0, z);
    
    stroke(255,constrain(desc.length()*10,0,255));
    line(0, 0, 0,0, -desc.length()*10, 0);
    fill(255,constrain(desc.length()*10,0,255));
    
    noStroke();
    pushMatrix();
    translate(0,lerp(0,-desc.length()*10,(sin(frameCount*0.1)+1)*0.5),0);
    sphereDetail(4);
    sphere(3);
    popMatrix();
    
    rotateY(-frameCount*0.01);
    text(desc,0, -desc.length()*10, 0);
    popMatrix();
  }
}
