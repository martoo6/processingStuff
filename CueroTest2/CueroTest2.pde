PImage img;
int count=0;
PVector p1=new PVector(-1, -1);
PVector p2=new PVector(-1, -1);
PVector p3=new PVector(-1, -1);
PVector p4=new PVector(-1, -1);
PGraphics calculated;
ArrayList<PVector> thisIsBackground;
ArrayList<PVector> thisIsCuero;

void setup() {
  img = loadImage("cuero.jpg");
  size(img.width, img.height);
  calculated = createGraphics(img.width, img.height);
  thisIsBackground = new ArrayList<PVector>();
  thisIsCuero = new ArrayList<PVector>();
}

void draw() {
  noStroke();
  image(img, 0, 0);
  stroke(255, 0, 0);
  if (p1.x!=-1 && p2.x!=-1) line(p1.x, p1.y, p2.x, p2.y);
  for(PVector p:thisIsBackground){
    set((int)p.x,(int)p.y, color(255,0,0));
  }
  for(PVector p:thisIsCuero){
    set((int)p.x,(int)p.y, color(0,0,255));
  }
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
  double distance = p1.dist(p2); //1cm = distance
  println("Distance calculated !");
  double pixelSize = 1.0/(distance*distance);
  println("Pixel Size Calculated !");
  long cantPixels=0;
  long cantPixels2=0;
  for (int y=0;y<img.height;y++) {
    for (int x=(int)p1.x+50;x<img.width;x++) {
     cantPixels2++; 
      if (green(img.get(x, y))<240) {
        cantPixels++;
        thisIsCuero.add(new PVector(x,y));
      }else{
        thisIsBackground.add(new PVector(x,y));
      }
    }
  }
  println("Pixel Count Finished !");
  println("------------------------------------");
  println("Cant Pixels: "+cantPixels);
  println("Cant Pixels Total: "+cantPixels2);
  println("Distance is: "+distance);
  println("Pixels Size: "+pixelSize);
  println("Tamaño del cuero: "+cantPixels*pixelSize +"cm2");
  println("Tamaño del cuero: "+cantPixels*pixelSize*0.0001 +"m2");
}
