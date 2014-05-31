import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

PImage img;
final int zoom=400;
ArrayList<Location> locations = new ArrayList<Location>();

PeasyCam cam;

void setup() {
  size(1280, 720, P3D);
  cam = new PeasyCam(this, 0,-100,100, 400);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(5500);
  cam.rotateX(PI/4);
  String[] s = loadStrings("comunas.csv");
  float topLimit=-Float.MAX_VALUE, bottomLimit=Float.MAX_VALUE, rightLimit=-Float.MAX_VALUE, leftLimit=Float.MAX_VALUE;
  for (int e=1;e<s.length;e++) {

    String[] tokens = splitTokens(s[e], ",[]\"");
    Location loc = new Location(tokens[0]);
    for (int i=12;i<tokens.length-1;i+=2) {
      try {  
        PVector p = new PVector(Float.parseFloat(tokens[i]), Float.parseFloat(tokens[i+1]));
        if (p.x<leftLimit) leftLimit=p.x;
        if (p.x>rightLimit) rightLimit=p.x;
        if (p.y<bottomLimit) bottomLimit=p.y;
        if (p.y>topLimit) topLimit=p.y;
        loc.addShapePoint(p);
      }
      catch(NumberFormatException ex) {
        String str= String.format("Error parsing Location: %s, can not convert data: %s", tokens[0], tokens[i]);
        println(str);
      }
    }
    locations.add(loc);
  }
  for (Location l:locations)  l.init(topLimit, bottomLimit, rightLimit, leftLimit);
}

void draw() {
  background(0);
  fill(255);
  strokeWeight(2 );
  stroke(0);
  pushMatrix();
  rotateY(frameCount*0.01 );
  for (Location l:locations) l.render();
  for (Location l:locations) l.renderLabel();
  popMatrix();
}

class Location {
  final int amp=500;
  ArrayList<PVector> shapePoints=new ArrayList<PVector>();
  String desc;
  PVector center;
  final int detail =2;


  Location(String _desc) {
    desc = _desc;
  }

  Location addShapePoint(float coordS, float coordW) {
    shapePoints.add(new PVector(coordS, coordW));
    return this;
  }

  Location addShapePoint(PVector p) {
    shapePoints.add(p);
    return this;
  }

  Location init(float tL,float bL,float rL,float lL) {
    float topLimit=-Float.MAX_VALUE, bottomLimit=Float.MAX_VALUE, rightLimit=-Float.MAX_VALUE, leftLimit=Float.MAX_VALUE;
    for (PVector p:shapePoints) {
      //Map limits in boundaries for easier usage
      p.set(map(p.x, lL, rL, -1, 1), map(p.y, bL, tL, -1, 1));
      if (p.x<leftLimit) leftLimit=p.x;
      if (p.x>rightLimit) rightLimit=p.x;
      if (p.y<bottomLimit) bottomLimit=p.y;
      if (p.y>topLimit) topLimit=p.y;
    }
    center = new PVector(lerp(topLimit, bottomLimit, 0.5), lerp(leftLimit, rightLimit, 0.5));    
    return this;
  }
  
  Location render(){
    stroke(0);
    fill(255);
    beginShape( );
    int i=0;
    for (PVector s:shapePoints) {
      if(i%detail==0) vertex(s.x*amp, 0, s.y*amp);
      i++;
    }
    endShape();
    return this;
  }
  
  Location renderLabel(){
    stroke(150);
    line(center.x*zoom, 0,center.y*zoom, center.x*zoom, -200,center.y*zoom);
    noStroke();
    fill(255);
    pushMatrix();
    textAlign(CENTER);
    translate(center.x*zoom, -200, center.y*zoom);
    rotateY(-frameCount*0.01);
    rotateX(PI/4);
    text(desc, 0,0,0);
    popMatrix();
    return this;
  }
}
