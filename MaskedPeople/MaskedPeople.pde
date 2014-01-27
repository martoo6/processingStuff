import processing.video.*;   

Movie mov; 
boolean cheatScreen; 
PImage img;
PImage mskImg;
PShader mskShader;
PGraphics g; 
  
void setup() { 
  size(1024, 768, P2D);

  mskImg = createImage(width, height, ARGB);
  

  mskShader = loadShader("mask.glsl");
  mskShader.set("mask", mskImg);
  
  // Start capturing the images from the camera 
  mov = new Movie(this, "ad.mp4");
  mov.loop();
  mov.read();
  
  mov.volume(0); //Uncomment if you want to hear the audio
  
  img = loadImage("stars.jpeg");

  g = createGraphics(width, height, P2D);
} 

void draw() {
  if (mov.available() == true) {
    background(0);
    mov.read();
        
    final int despX = round(sin(frameCount*0.03)*width*0.25);
    final int despY = round(sin(frameCount*0.07)*height*0.25);
    final PImage tmpImg = img.get(width/4+despX,height/4+despY,width,height);   
    
    mskImg.copy(mov,0,0, mov.width, mov.height, 0,0, width, height);//This does the resize itself
    
    mskShader.set("mask", mskImg);
    g.beginDraw();
      g.background(0);
      g.shader(mskShader);
      g.image(tmpImg, 0, 0, width, height);
    g.endDraw();
    
    image(g,0,0);
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
