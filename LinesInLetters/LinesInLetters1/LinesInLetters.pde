void setup() {
  size(1280, 500);
  background(255);
  smooth();
  noLoop();
}

void draw() {
  stroke(0,10);
  textSize(100);
  for (int i=0;i<20;i++) {
    pushMatrix();
    translate(i*70,100);
    PGraphics txt= getLetter(char(70+i));
    for (int e=0;e<500;e++) {
      PVector p1 = getRandomPos(txt);
      PVector p2 = getRandomPos(txt);

      line(p1.x, p1.y, p2.x, p2.y);
    }
    popMatrix();
  }
}

PVector getRandomPos(PGraphics img) {
  float x = random(img.width);
  float y = random(img.height);
  while (img.get ( (int)x, (int)y)!=color(0)) {
    x = random(img.width);
    y = random(img.height);
  }
  return new PVector(x, y);
}

PVector getRandomPos(PGraphics img,PVector orig,float maxRadius) {
  float x = random(img.width);
  float y = random(img.height);
  while (img.get ( (int)x, (int)y)!=color(0)) {
    x = random(img.width);
    y = random(img.height);
  }
  return new PVector(x, y);
}

PGraphics getLetter(char c) {
  String str = ""+c;
  float w=textWidth(str);
  float h=textAscent()+textDescent();

  PGraphics txt= createGraphics((int)w, (int)h);
  txt.beginDraw();
  txt.background(255);
  txt.fill(color(0));
  txt.textSize(100);
  txt.textAlign(CENTER, CENTER);
  txt.text(str, txt.width/2, txt.height/2);
  txt.endDraw();

  return txt;
}
