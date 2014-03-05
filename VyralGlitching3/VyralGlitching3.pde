int y=0, z=0;
color []colors = {#3DEDFF, #E868CE, #FDFF00, #00FFB1, #FF0000}; 

void setup(){
  size(1280,720);
  background(0);
}

void draw(){
  //background(0);
  fill(0,0,0,10); rect(0,0,width, height);
  loadPixels();
  for(int x=0;x<width;x++){
    //final int pos = x*x&y*x;
    //final int pos = x*x+x&y*x;
    //final int pos = ((x*y)<<y);
    final int pos = ((x*y)|y);
    pixels[constrain(pos,0,pixels.length-1)]=color(colors[(z)%colors.length]);
  }
  updatePixels();
  y++;
  if(y%200==0) z++;
  if(y>height) {
    y=0;
  }
}