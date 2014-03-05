// Using brightness of image to map for position

import java.util.*;

PImage img;

 

void setup(){
  img = loadImage("tape-face-2.jpg");
  size(img.width,img.height);
  noLoop();
}



void draw(){
  image(
  vGlich(hGlich(img,0.02), 0.02)
  ,0,0);  
}

public PImage hGlich(PImage img, float amount/*From 0.0 to 1.0*/){
  PImage hGliched = img.get();
  int s;
  for(int y=0;y<img.height;y+=s){
      s = (int)random(10,30);
      int displacement = (int)random(-width*amount,width*amount);
      hGliched.copy(img, 0, y, width, s, displacement, y, width, s);
  }
  return hGliched;
}

public PImage vGlich(PImage img, float amount/*From 0.0 to 1.0*/){
  PImage vGliched = img.get();
  int s;
  for(int x=0;x<img.width;x+=s){
      s = (int)random(10,30);
      int displacement = (int)random(-height*amount,height*amount);
      vGliched.copy(img, x, 0, s, height, x, displacement, s, height);
  }
  return vGliched;
}

void mouseClicked(){
  redraw();
}
