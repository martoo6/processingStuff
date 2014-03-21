void setup(){
  size(800,600, P3D);
  background(0);
  //noLoop();
  sphereDetail(5 );
}

void draw(){
  background(0);
  translate(width/2, height*0.75);
  rotateY(frameCount*0.01);
  for(int i=0;i<100;i++){
    PVector p1 = new PVector(noise(i)*width-width/2.0,noise(i+20)*height-height/2.0);
    PVector p2 = new PVector(noise(i+60)*width-width/2.0,noise(i+30)*height-height/2.0);
    PVector p3 = PVector.lerp(p1,p2,0.5);
    float dist = p1.dist(p2); //height
    noFill();
    stroke(255,20);
    bezier(p1.x, 0 ,p1.y, p3.x, -dist*0.5 ,p3.y,p3.x, -dist*0.5 ,p3.y, p2.x, 0 ,p2.y);
    float pos = (sin((frameCount)/dist)+1)/2;
    float x = bezierPoint(p1.x, p3.x, p3.x, p2.x, pos);
    float y = bezierPoint(0, -dist*0.5, -dist*0.5, 0, pos);
    float z = bezierPoint(p1.y, p3.y, p3.y, p2.y, pos);
    pushMatrix();
    translate(x,y,z);
    fill(255,50);
    sphere(1);
    popMatrix();    
  }
}
