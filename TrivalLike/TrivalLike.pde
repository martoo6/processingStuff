PVector obj;
PVector pos;

ArrayList<PVector> prevPoints = new ArrayList<PVector>(); 

void setup(){
  size(800,600);
  background(0);
  obj = new PVector(random(width), random(height));
  pos = new PVector(random(width), random(height));
  prevPoints.add(pos);
  stroke(255);
}

void draw(){  
  calcNewPoint();
  stroke(255);
  noFill();
  beginShape();
  for(PVector p :prevPoints) {
    if(p.x==0 && p.y==0){
      endShape();
      beginShape();
    }else{
      curveVertex(p.x, p.y);
    }
  }
  endShape();
}

void calcNewPoint(){
  float dist = pos.dist(obj);
  fill(0);
  rect(0,0,100,60);
  fill(255);
  text(dist, 20, 40);
  
  //Arrival !
  if(dist<10){
    obj = new PVector(random(width), random(height));
    pos = new PVector(random(width), random(height));
    prevPoints.add(new PVector(0,0));
  }
  
  PVector p = PVector.sub(obj,pos);
  p.normalize();
  p.mult(5);
  pos.add(p);
  
  //PVector rand = PVector.fromAngle(noise(pos.x*0.0001, pos.y*0.0001)*TWO_PI*100);
  PVector rand = PVector.fromAngle(noise(frameCount*0.0001)*TWO_PI*100);
  rand.mult(5);
  rand.limit(pos.dist(prevPoints.get(prevPoints.size()-1)));
  
  
  pos.add(rand);
  
  prevPoints.add(pos.get());
}
