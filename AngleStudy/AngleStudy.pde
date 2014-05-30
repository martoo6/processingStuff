PVector p;

void setup() {
  size(500, 500, P3D);
  background(0);
  //p = new PVector(1,0,0);
  p = PVector.random3D();
  p.mult(200);
}

void draw() {
  background(0);
  pushMatrix();
  translate(width*0.25, height*0.65, -100);

  //Axis
  strokeWeight(1);
  stroke(255 );
  line(-1000, 0, 0, 1000, 0, 0);
  line(0, -1000, 0, 0, 1000, 0);
  line(0, 0, -1000, 0, 0, 1000);

  

  //Original Line
  strokeWeight(4);
  stroke(0, 255, 0);//GREEN
  line(0, 0, 0, p.x, p.y, p.z);
  noStroke();
  pushMatrix();
  translate(p.x, p.y, p.z);
  sphere(10);
  popMatrix();
  
  
  //With rotation should be the same
  
  pushMatrix();
  rotateY(atan2(p.y, p.x)+PI/2);
  
  stroke(255, 0, 0);//RED
  line(-1000, 0, 0, 1000, 0, 0);
  line(0, -1000, 0, 0, 1000, 0);
  line(0, 0, -1000, 0, 0, 1000);
  
  /*rotateX(atan2(p.y, p.z)+PI/2);
  
  stroke(255, 0, 255);//PURPLE
  line(-1000, 0, 0, 1000, 0, 0);
  line(0, -1000, 0, 0, 1000, 0);
  line(0, 0, -1000, 0, 0, 1000);*/
  
  //Should be the same
  stroke(255, 0, 0);
  popMatrix();


  popMatrix();
}

void mouseClicked(){
  p = PVector.random3D();
  p.mult(100);
}
