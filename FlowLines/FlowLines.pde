ArrayList<LineGroup> groupCol = new ArrayList<LineGroup>();

void setup(){
  size(displayWidth, displayHeight, OPENGL);
  background(#5F5F5F);
  noFill();
  //noSmooth();
  for(int j=0;j<10;j++) groupCol.add(new LineGroup().setDispersion(random(0.01,0.05)).generateLineColl(10));
}

void draw(){
  background(#5F5F5F);
  int sd=1;
  for(LineGroup lg: groupCol){
    lg.render(sd);
    sd*=2;
  }
}

class LineGroup{
  color c = color(86,180,237,80);
  int amount = 10;
  float dispersion = 0.02;
  ArrayList<SingleLine> lines = new ArrayList<SingleLine>();
  
  
  void render(float sd){
    stroke(c);
    for(int e=0;e<amount;e++){
      lines.get(e).render(e*dispersion+sd);
    }
  }
  
  LineGroup generateLineColl(int amount){
    this.amount = amount;
    for(int i=0;i<amount;i++) lines.add(new SingleLine());
    return this;
  }
  
  LineGroup setDispersion(float dispersion){
    this.dispersion = dispersion;
    return this;
  }
}

class SingleLine{
  void render(float sd){
    beginShape();
    for(float i=0;i<=width;i+=abs(noise(sd)*5)*50){
        curveVertex(i,  50 + noise(i*0.002,sd, frameCount*0.01)*600);
        //ellipse(i,  50 + noise(i*0.002,sd, frameCount*0.01)*600, 10, 10);
    }
    endShape();
  }
}
