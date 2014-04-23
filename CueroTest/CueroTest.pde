PImage img;
int count=0;
PVector p1=new PVector(-1, -1);
PVector p2=new PVector(-1, -1);
PGraphics calculated;

void setup() {
  img = loadImage("cuero.jpg");
  size(img.width, img.height);
  calculated = createGraphics(img.width, img.height);
}

void draw() {
  noStroke();
  image(img, 0, 0);
  stroke(255, 0, 0);
  if (p1.x!=-1 && p2.x!=-1) line(p1.x, p1.y, p2.x, p2.y);
}

void keyPressed() {
  if (key=='c') {
    calculate();
  }

  if (key=='1') p1 = new PVector(mouseX, mouseY);
  if (key=='2') p2 = new PVector(mouseX, mouseY);
}

void mouseClicked() {
}

void calculate() {
  //img.filter(THRESHOLD);
  //println("THRESHOLD Applied !");
  float distance = p1.dist(p2); //1cm = distance
  println("Distance calculated !");
  float pixelSize = 1.0/distance;
  println("Pixel Size Calculated !");
  long cantPixels=0;
  for (int y=0;y<img.height;y++) {
    for (int x=0;x<img.width-200;x++) { 
      if ((img.get(x, y))!=color(0, 255, 0)) {
        cantPixels++;
        
      }
    }
  }
  println("Pixel Count Finished !");
  println("------------------------------------");
  println("Cant Pixels: "+cantPixels);
  println("Pixels Size: "+pixelSize);
  println("Tamaño del cuero: "+cantPixels*pixelSize +"cm2");
  println("Tamaño del cuero: "+cantPixels*pixelSize*0.0001 +"m2");
}
