/**
 * Image Mask
 * 
 * Move the mouse to reveal the image through the dynamic mask.
 */
import processing.video.*; 
PShader maskShader;
PImage srcImage;
PGraphics maskImage;

Movie mov; 

void setup() {
  size(640, 360, P2D);
  srcImage = loadImage("leaves.jpg");
  //mov = new Movie(this, "ad.mp4");
  //mov.loop();
  //mov.read();
  //mov.volume(0); //Uncomment if you want to hear the audio
  maskImage = createGraphics(srcImage.width, srcImage.height, P2D);
  maskImage.noSmooth();
  maskShader = loadShader("mask.glsl");
  maskShader.set("mask", maskImage);
  background(255);
  maskImage.beginDraw();
  maskImage.background(255);
  maskImage.endDraw();
}

void draw() { 
  image(srcImage, 0, 0, width, height);
  maskImage.beginDraw();
  if (mouseX != 0 && mouseY != 0) {  
    maskImage.noStroke();
    maskImage.fill(0);
    maskImage.ellipse(mouseX, mouseY, 50, 50);
  }
  maskImage.endDraw();
  
  maskShader.set("mask", maskImage);
  
  shader(maskShader);    
  
  //image(srcImage, 0, 0, width, height);
  //image(maskImage, 0, 0, width, height);
  if(frameCount%2==0) println(frameRate);
}
