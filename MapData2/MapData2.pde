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
  translate(width / 2, height *0.75);
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
  
  
  translate(width / 2, height *0.75);
  rotateY(frameCount*0.01);
  
  stroke(255);
  for(int i=0;i<100;i++) {
    Location l1= locations.get(floor(noise(i)*(locations.size()-1)));
    Location l2= locations.get(floor(noise(i+10)*(locations.size()-1)));
    PVector p1 = l1.pos;
    PVector p2 = l2.pos;
    PVector p3 = PVector.lerp(p1,p2, 0.5);
    if(i==1) println(p1,p2,p3);
    line(p1.x, 0, p1.y, p3.x, -200, p3.y);
    line(p2.x, 0, p2.y, p3.x, -200, p3.y);
    //bezier(p1.x,0,p1.y, p3.x,-200,p3.y, p3.x,-200,p3.y, p2.x,0,p2.y);
  }
  
  popMatrix();
}

class Location{
  PVector pos;
  String desc;
  
  Location(String _desc, float coordS, float coordW){
    pos = new PVector(coordW, coordS);
    desc = _desc;
  }
}
