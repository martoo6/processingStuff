ArrayList<LineGroup> groupCol = new ArrayList<LineGroup>(); 
void setup() { 
  size(displayWidth, displayHeight); 
  background(#5F5F5F); 
  noFill(); 
  //frameRate(30);
  for (int j=0;j<5;j++) groupCol.add(new LineGroup().setDispersion(0.02));
} 
void draw() { 
  background(#5F5F5F); 
  for (LineGroup lg: groupCol) lg.render();
  if(frameCount%10 == 0) println(frameRate);
} 
class LineGroup {
  color c = lerpColor(color(255, 255, 0, 80), color(0, 255, 255, 80), random(0, 1)); //Line group color 
  int amount = 10; 
  float dispersion = 0.02; 
  int gsd = (int)random(100);//Group Seed, allows different shapes 
  float detail = 0.002; 
  int amp = 400;
  int step=width/8;
 
  void render() { 
    stroke(c); 
    renderCurve(); 
    //renderLines();
  } 

  void renderCurve() { 
    float xVar = frameCount*4; //Allows movement on the x axis
    for (int e=0;e<amount;e++) { 
      float eDisp = e*dispersion+gsd; 
      beginShape(); 
      for (int i=0;i<2;i++) curveVertex(0, noise(xVar*detail, eDisp)*amp); //Twice in order to have the borders drawn
      
      for (int i=0;i<width;i+=step){
        curveVertex(i, noise((i+xVar)*detail, eDisp)*amp);
      } 
      for (int i=0;i<2;i++) curveVertex(width, noise((width+xVar)*detail, eDisp)*amp); //Twice in order to have the borders drawn 
      endShape();
    }
  } 
  void renderLines() { 
    float xVar = frameCount*5; 
    for (int e=0;e<amount;e++) { 
      beginShape(); 
      float eDisp = e*dispersion; 
      for (float i=0;i<width;i+=1) vertex(i, noise(gsd+(i+xVar)*detail, eDisp)*amp); 
      endShape();
    }
  } 
  LineGroup setDispersion(float dispersion) { 
    this.dispersion = dispersion; 
    return this;
  }
} 
boolean sketchFullScreen() { 
  return true;
}

