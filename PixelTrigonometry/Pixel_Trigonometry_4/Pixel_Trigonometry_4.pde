PShader shader;


void setup(){
  size(1280,720, P2D);
  shader = loadShader("mask.glsl");
}

void draw(){
  frame.setTitle(Integer.toString((int)(frameRate)));
  shader.set("time", (float) frameCount);
  shader.set("detail", map(mouseX, 0, width, 0, 50)*pow(2,map(mouseY,0,height,0,10)));
  shader(shader);
  rect(0,0,width,height);
}

void keyPressed()
{
  setup();
}
