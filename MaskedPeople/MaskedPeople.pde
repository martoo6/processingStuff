import processing.video.*;   

Movie mov; 
boolean cheatScreen; 
PImage img;
int w =1280;
int h =720;
PGraphics tmpImg;
  
void setup() { 
  size(w, h);
  
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
    mov.loadPixels();
    
    
    
    PImage tmpImg = img.get(frameCount,0,width,height); 
    PGraphics g = createGraphics(width,height);
    
    PImage tmpImg2 = get(0,0, mov.width, mov.height);
    tmpImg2.resize(w,h); //So i can apply mask
    
    for(int i=0;i<width;i++){
      for(int e=0;e<height;e++){
        if(brightness(tmpImg2.get(i,e))>100) g.set(i,e,tmpImg.get(i,e));
      }
    }
    
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

