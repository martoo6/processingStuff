import processing.video.*;   

Movie mov; 
boolean cheatScreen; 
PImage img;
  
void setup() { 
  size(displayWidth, displayHeight);
  
  // Start capturing the images from the camera 
  mov = new Movie(this, "ad.mp4");
  mov.loop();
  mov.read();
  
  mov.volume(0); //Uncomment if you want to hear the audio
  
  img = loadImage("stars.jpeg");   
} 

void draw() {
  if (mov.available() == true) {
    background(0);
    mov.read();
        
    final PImage tmpImg = img.get((width/2)+round(sin(frameCount*0.03)*width*0.25),0,width,height); 
    //tmpImg.tint();
    PGraphics g = createGraphics(width,height);
    
    PImage tmpImg2 = createImage(width, height, ARGB); 
    tmpImg2.copy(mov,0,0, mov.width, mov.height, 0,0, width, height);//This does the resize itself
    //tmpImg2.filter(BLUR);
    
    mov.loadPixels();
    tmpImg2.loadPixels();
    tmpImg.loadPixels();
    g.beginDraw();
      g.loadPixels();
        for(int i=0;i<g.pixels.length;i++) if(brightness(tmpImg2.pixels[i])<1) g.pixels[i] = tmpImg.pixels[i];
      g.updatePixels();
    g.endDraw();
    
    
    set(0, 0, g);
    if(cheatScreen) set(0, 0, mov);
  }
  text(frameRate, 20, 20);
} 

void keyPressed() { 
  switch (key) { 
  case 'g': 
    saveFrame(); 
    break; 
  case 'c': 
    cheatScreen = !cheatScreen; 
    break;
  }
}

