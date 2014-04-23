import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

PShape map;

PeasyCam cam;

void setup() {
  size(1280,720, P3D);
  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(4500);
  map = loadShape("argentina.svg");
} 

void draw(){
  background(0);
  float w=map.getWidth();
  float h=map.getHeight();
  pushMatrix();
  //translate(width/2,height/2);
  //rotateY(frameCount*0.1);
  //rotateX(PI/2);
  rotateZ(frameCount*0.01);
  shape(map, -w/2, -h/2);
  popMatrix();
}
