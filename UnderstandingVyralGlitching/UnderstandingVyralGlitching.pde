int x=0;

void setup(){
  size(800,600);
  background(0);
}

void draw(){
  background(0);
  loadPixels();
  //for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      pixels[x*y]=color(255);
    }
  //}
  updatePixels();
  x++;
  if(x>width) x=0;
  delay(50);
}
