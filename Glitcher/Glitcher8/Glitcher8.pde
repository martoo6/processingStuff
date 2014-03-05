// Using brightness of image to map for position

import java.util.*;

PImage img;

 

void setup(){
  img = loadImage("tape-face-2.jpg");
  size(img.width,img.height);
}



void draw(){
  img = hGlich(img,0.1, 0.01);
  img = vGlich(img, 0.1, 0.01);
  image(img,0,0);
}

public PImage hGlich(PImage img, float amount/*From 0.0 to 1.0*/, float randomness/*from o.o to 1.0*/){
  PImage hGliched = img.get();
  for(int y=0;y<img.height;y++){
      int displacement = (int)(noise(y*randomness, frameCount*0.01)*width*amount*2-width*amount);
      hGliched.copy(img, 0, y, width, 1, displacement, y, width, 1);
  }
  return hGliched;
}

public PImage vGlich(PImage img, float amount/*From 0.0 to 1.0*/, float randomness/*from o.o to 1.0*/){
  PImage vGliched = img.get();
  for(int x=0;x<img.width;x++){
      int displacement = (int)(noise(x*randomness, frameCount*0.01)*height*amount*2-height*amount);
      vGliched.copy(img, x, 0, 1, height, x, displacement, 1, height);
  }
  return vGliched;
}

void mouseClicked(){
  redraw();
}
