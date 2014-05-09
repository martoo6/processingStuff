import peasy.*;

PeasyCam cam;

int cant = 100;
float large =20;
float rateChange=0.1;
int distPoints=5;
Boolean b=true;
ArrayList<PVector> initPos = new ArrayList<PVector> (); 
PImage img;

void setup(){
  img = loadImage("http://www.culture24.org.uk/asset_arena/0/99/88/188990/v0_master.jpg");
  size(img.width,img.height);
  colorMode(HSB);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1500);
  background(0 );
  noFill();
  strokeWeight(2);
}

void draw(){
  image(img,0,0);
  for(int i=0;i<initPos.size();i++){
    float x = noise(i,0)-0.5;
    float y = noise(i,8);
    PVector dir = new PVector(x,y);
    dir.mult(distPoints);
    beginShape();
    PVector init = initPos.get(i );
    vertex(init.x,init.y);
    dir.add(init);
    for(int e=0;e<large;e++){
      stroke((255.0/cant)*i,255,255, b?180:10);
      vertex(dir.x,dir.y);
      float xT = noise(i,e*rateChange+frameCount*0.01)-0.5;
      float yT = noise(i+33,e*rateChange+frameCount*0.01);
      PVector tmp = new PVector(xT*yT*4, yT);
      tmp.mult(distPoints);
      dir.add(tmp);
    }
    endShape();
  }
}

void mousePressed(){
  initPos.add(new PVector(mouseX, mouseY));
}
