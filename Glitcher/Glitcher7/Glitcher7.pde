// Using brightness of image to map for position

import processing.video.*;

Movie mov; 
boolean cheatScreen; 

void setup(){
    // Start capturing the images from the camera 
  mov = new Movie(this, "video.mp4");
  mov.loop();
  while(!mov.available());
  mov.read();
  mov.volume(0); //Uncomment if you want to hear the audio
  
  size(mov.width,mov.height);
}



void draw(){
    if (mov.available()) {
      mov.read();
      mov.loadPixels();
      image(hGlich(mov.get(),0.02),0,0);  
    }
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
