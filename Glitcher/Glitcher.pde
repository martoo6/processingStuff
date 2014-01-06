PImage img;

void setup(){
  img = loadImage("tape-face-2.jpg");
  size(img.width,img.height);
  println(img.width, img.height);
  noLoop();  
}

void draw(){
  image(img,0,0);
  int cant = (int)random(100,1000);
  for(float e=1;e<cant;e++){
    int xDest = (int)random(img.width);
    int yDest = (int)random(img.height);
    int xStart = (int)random(img.width);
    int yStart = (int)random(img.height);
    int xAmount = (int)random(10,200);
    while(xStart+xAmount>width) xAmount = (int)random(0,400); //Image crop must be between boundaries
    int yAmount = (int)random(10,200);
    while(yStart+yAmount>height) yAmount = (int)random(0,400); //Image crop must be between boundaries
    for(int x=0;x<xAmount;x++) for(int y=0;y<yAmount;y++)  set(xDest+x,yDest+y, img.get(xStart+x,yStart+y)); //Set pixel color from image
  }
}
