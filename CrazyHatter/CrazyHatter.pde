import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

PImage img;
ArrayList<Circle> circles = new ArrayList<Circle>();  

PeasyCam cam;

void setup(){
  img = loadImage("http://img2.wikia.nocookie.net/__cb20100313203002/aliceinwonderland/es/images/d/d8/2010-Mad_Hatter.jpg");
  img.resize(img.width/2,img.height/2);
  size(img.width, img.height, P3D);
  
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(3500);
  
  noStroke();
  background(0);
  for(int i=0;i<100000;i++){
    Circle tmpCircle = new Circle();
    Boolean col=false;
    for(Circle c :circles){
      if(PVector.dist(tmpCircle.pos,c.pos)-(tmpCircle.size+c.size)*0.5<0){
        col=true;
        break;
      }
    }
    if(!col) circles.add(tmpCircle);
  }  
  
  for(Circle c :circles) {
    fill(img.get((int)c.pos.x,(int)c.pos.y));
    translate(c.pos.x, c.pos.y, c.size);
    sphere(c.size);
  }
  
}

void draw(){
  
  background(0);
  for(Circle c :circles) {
    color cTmp = img.get((int)c.pos.x,(int)c.pos.y); 
    fill(cTmp);
    pushMatrix();
    translate(-width/2, -height/2, brightness(cTmp));
    ellipse(c.pos.x, c.pos.y, c.size, c.size);
    popMatrix();
  }
}

class Circle{
  PVector pos=new PVector(random(width), random(height));
  float size=random(2,6);
}
