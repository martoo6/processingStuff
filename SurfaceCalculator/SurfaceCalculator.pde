PImage img;
PVector p1 = new PVector(), p2 = new PVector();
ArrayList<PVector> detectedPixels = new ArrayList<PVector>(); 

void setup() {
  img = loadImage("ruler.gif");
  size(img.width, img.height);
}

void draw() {
  background(img);
  for(PVector p: detectedPixels) set((int)p.x,(int)p.y,color(255,0,0));
}

void keyPressed() {
  if (key=='1') p1.set(mouseX, mouseY);
  if (key=='2') p2.set(mouseX, mouseY);
  if (key=='c') {
    //Calculations
    double pSize = 1/p1.dist(p2);
    double errorSize = 0.1/p1.dist(p2);
    long cantPixels=0;


    for (int y=0;y<30;y++) {
      for (int x=0;x<img.width;x++) {
        if(brightness(img.get(x,y))<50) {
          cantPixels++;
          detectedPixels.add(new PVector(x,y));
        }
      }
    }

    //Results
    println("_____________________________");
    println("Pixel distance: "+p1.dist(p2));
    println("Pixel size: "+pSize*pSize+" cm2");
    println("Thing size: "+pSize*pSize*cantPixels+" cm2");
    println("Error size: "+errorSize);
    println("Error size in thing: "+errorSize*cantPixels);
    println("Pixel cant: "+cantPixels);
  }
}
