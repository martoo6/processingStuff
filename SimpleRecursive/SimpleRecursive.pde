void setup(){
  size(600,600);
  noLoop();
}

void draw(){
  background(0);
  for(int y=0;y<height;y++){
    for(int x=0;x<width;x++){
      set(x,y,color(int(noise(x*0.01,y*0.01)*255)));
    }
  }
  blend(0,0,width,height,0,0,width,height, SCREEN);
  drawRect(0,0,1);
}

void drawRect(float x, float y, float depth){
  if(depth>=64 || random(10)>8){
    if(random(1)>0.5) fill(0); else fill(100);
    stroke(60);
    rect(x,y, width/depth, height/depth);
    return;
  }
  depth*=2;
  drawRect(x,y,depth);
  drawRect(x+(width/depth),y,depth);
  drawRect(x,y+(height/depth),depth);
  drawRect(x+(width/depth),y+(height/depth),depth);
}

void keyPressed(){
  redraw();
}
