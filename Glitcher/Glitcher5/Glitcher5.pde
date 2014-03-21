PImage img;
PGraphics glitched;
PShader glitchingShader;

void setup(){
  img = loadImage("tape-face-2.jpg");
  size(img.width,img.height, P2D);
  glitchingShader = loadShader("shader.glsl");
  glitched = createGraphics(width, height, P2D);
}



void draw(){
  blendMode(REPLACE);
  background(0);
  glitched.beginDraw();
  glitched.rect(0,0, width, height);
  glitched.shader(glitchingShader);
  glitched.endDraw();
  image(glitched,0,0);
  blendMode(MULTIPLY);
  image(img,0,0);
}
