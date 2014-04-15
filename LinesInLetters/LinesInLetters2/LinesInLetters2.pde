void setup() {
  size(1280, 500);
  background(255);
  smooth();
  noLoop();
}

void draw() {
  textSize(100);
  String str="@#$%&abcdefghi";
  
  for(int i=0;i<str.length();i++){
    drawText(str.charAt(i)+"", 1000,new PVector(i*100 ,0));
  }
}


void drawText(String str,int density ,PVector pos) {
  stroke(0, 30);
  pushMatrix();
  translate(pos.x, pos.y);
  PGraphics txt= getText(str, 400);
  PVector p1 = getRandomPos(txt);
  PVector p2 = getRandomPos(txt, p1, 30);
  for (int e=0;e<density;e++) {
    line(p1.x, p1.y, p2.x, p2.y);
    p1 = p2;
    p2 = getRandomPos(txt, p1, 30);
  }
  popMatrix();
}

//Get random pos where the color is black
PVector getRandomPos(PGraphics img) {
  float x = random(img.width);
  float y = random(img.height);
  while (img.get ( (int)x, (int)y)!=color(0)) {
    x = random(img.width);
    y = random(img.height);
  }
  return new PVector(x, y);
}

//Get random pos where the color is black but the distince from a provious point is fixed
PVector getRandomPos(PGraphics img, PVector orig, float maxRadius) {
  PVector sum = PVector.fromAngle(random(TWO_PI)); 
  sum.mult(random(maxRadius));
  sum.add(orig);
  while (img.get ( (int)sum.x, (int)sum.y)!=color(0)) {
    sum = PVector.fromAngle(random(TWO_PI)); 
    sum.mult(random(maxRadius));
    sum.add(orig);
  }
  return sum;
}

PGraphics getText(String str,float size) {
  textSize(size);
  float w=textWidth(str);
  float h=textAscent()+textDescent();
  if(w<2 || h<2) {
    PGraphics txt= createGraphics(100, 100);
    txt.beginDraw();
    txt.background(color(0));
    txt.endDraw();
    return txt;
  } 
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
