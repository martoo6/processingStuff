PImage webImg;
ArrayList<PVector> list;
PGraphics showImage;
int drawingSpeed=1;

void setup() {
  background(0);
  String url = "http://static.wallarc.com/51a47f21e047f42440.jpg";  
  // Load image from a web server
  webImg     = loadImage(url);
  size(webImg.width, webImg.height, OPENGL);
  reset();
}

void draw() {
  background(0);
  showImage.beginDraw();
  for (int i=0;i<drawingSpeed;i++) {
    for (PVector v:list) {
      PVector d = PVector.fromAngle(noise((int)v.x*0.01, (int)v.y*0.01, frameCount*0.01)*TWO_PI*8);
      v.add(d);
      color c1 = webImg.get((int)v.x, (int)v.y);
      color c2 = showImage.get((int)v.x, (int)v.y);
      color cFinal = lerpColor(c1, c2, 0.6);
      showImage.set((int)v.x, (int)v.y, cFinal); //Faster than: stroke(c,50); point((int)v.x, (int)v.y);
    }
  }
  showImage.endDraw();
  image(showImage, 0, 0);
  text("FPS: "+frameRate, 20, 20);
}


void reset() {
  showImage = createGraphics(webImg.width, webImg.height);
  list = new ArrayList<PVector>();
  for (int i=0;i<1000;i++) {
    PVector pos = new PVector(random(width), random(height));
    while (brightness (webImg.get ( (int)pos.x, (int)pos.y))<10) pos = new PVector(random(width), random(height));
    list.add(pos);
  }
}

