//Creating a Text Cloud using per pixel colision detection. Using a regular grid in order to improve performance a little bit.
//The cloud uses OOP words. Nerdy shit (?)

import controlP5.*;
ControlP5 cp5;

final int CONST_TRIES = 20; //Amount of tries in order to locate the text
final int CONST_TOTAL_TRIES = CONST_TRIES*10; //Amount of times it decreases the text size
final int CONST_TEXT_SIZE = 60;
final int cellSize = 10;

String[] text;
PGraphics compositeImage;
int colisions;
boolean[][] grid; //Using a quadtree would improve performance
boolean seeGrid=false;

void setup() {
  size(displayWidth, displayHeight);
  
  cp5 = new ControlP5(this);
    cp5.addBang("grid")
       .setPosition(20, 20)
       .setSize(40, 40)
       .setLabel("See Grid")
       ;
  
  text = loadStrings("cloud.txt");
  grid = new boolean[width/cellSize][height/cellSize];
  compositeImage = createGraphics(width, height); 
  for (int x=0;x<width/cellSize;x++) for (int y=0;y<height/cellSize;y++) grid[x][y] = false;
  calculateCloud();
}

public void grid() {
  seeGrid= !seeGrid;
}

void draw() {
  background(0);
  if (seeGrid) {
    fill(255, 0, 255);
    for (int x=0;x<width/cellSize;x++) for (int y=0;y<height/cellSize;y++) if (grid[x][y]) rect(x*cellSize, y*cellSize, cellSize, cellSize);
  }
  
  fill(0);
  rect(0,0, 80, 80);
  
  image(compositeImage, 0, 0);
}


void calculateCloud() {
  for (int i=0;i<text.length;i++) {
    float textSize = CONST_TEXT_SIZE;
    int totalNumOfTries = 0;
    PGraphics tmpImg = getImageFromText(text[i], textSize);
    PVector pos = new PVector(random(0, width-tmpImg.width), random(0, height-tmpImg.height));
    while (gridColision (pos, tmpImg) && perPixelColision(tmpImg, pos, compositeImage) && totalNumOfTries<CONST_TOTAL_TRIES) {
      totalNumOfTries++;
      if (totalNumOfTries%CONST_TRIES==0) textSize/=1.3;
      tmpImg = getImageFromText(text[i], textSize);
      pos = new PVector(random(0, width-tmpImg.width), random(0, height-tmpImg.height));
    }
    if (totalNumOfTries < CONST_TOTAL_TRIES) {
      addToGrid(pos, tmpImg);
      compositeImage.beginDraw();
      compositeImage.image(tmpImg, pos.x, pos.y);
      compositeImage.endDraw();
    }
  }
}

PGraphics getImageFromText(String text, float size) {
  textSize(size);
  //If the img is smaller the check for collisions is faster 
  PGraphics  img = createGraphics(ceil(textWidth(text)), ceil(textDescent()+textAscent()), JAVA2D);
  img.textSize(size);
  img.fill(255);
  img.beginDraw();
  img.text(text, 0, textAscent());
  img.endDraw();
  return img;
}

boolean perPixelColision(PGraphics img1, PVector pos, PGraphics img2) {
  img1.loadPixels();
  img2.loadPixels();
  for (int x=0;x<img1.width;x++) {
    for (int y=0;y<img1.height;y++) {
      if (img2.get(x+(int)pos.x, y+(int)pos.y)!=0 && img1.get(x, y)!=0) return true;
    }
  }
  return false;
}

boolean gridColision(PVector pos, PGraphics img) {
  int endX = ceil((pos.x+img.width)/cellSize);
  int endY = ceil((pos.y+img.height)/cellSize);
  for (int x=floor(pos.x/cellSize);x<endX;x++) {
    for (int y=floor(pos.y/cellSize);y<endY;y++) {
      if (grid[x][y]) return true;
    }
  }
  return false;
}

void addToGrid(PVector pos, PGraphics img) {
  int endX = ceil((pos.x+img.width)/cellSize);
  int endY = ceil((pos.y+img.height)/cellSize);
  for (int x=floor(pos.x/cellSize);x<endX;x++) {
    for (int y=floor(pos.y/cellSize);y<endY;y++) {
      grid[x][y] = true;
    }
  }
}

