 import peasy.*;

PShape formas;
PShape forma;
float randTerrain=random(1000);
int tam=5;
int grillaTam=20;

PeasyCam cam;

void setup(){
  size(600,600, P3D);
  //stroke(100);
  noStroke();
  fill(255);
  background(0);
 



  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(600);
/*
  formas = new PShape(GROUP);

  for(int i=-200;i<200;i+=10){
    for(int e=-200;e<200;e+=10){
      forma = createShape(RECT,10,i,-noise(e*0.01,i*0.01,randTerrain)*200,e);
      
      formas.addChild(forma);
      //vertex(i,-noise(e*0.01,i*0.01)*200,e);
    } 
  }
  */
}

void draw(){
    background(0);
  frame.setTitle(Integer.toString((int)(frameRate)));
  pushMatrix();
  //translate(width/2,(height/4)*3,-100);
  rotateY(frameCount*0.001);
  /*beginShape();
  vertex(-100,0,-100);
  vertex(100,-20,-100);
  vertex(100,0,100);
  vertex(-100,0,100);
  endShape();
  
  */
  
  
 float altura1, altura2, altura3, altura4;
  for(int i=-grillaTam;i<grillaTam;i+=tam){
    for(int e=-grillaTam;e<grillaTam;e+=tam){
      pushMatrix();
      float cantFrames=frameCount*0.01;
      
      altura1=noise(e*0.01,i*0.01,randTerrain)*100;
      altura2=noise((e+tam)*0.01,i*0.01,randTerrain)*100;
      
      altura3=noise((e+tam)*0.01,(i+tam)*0.01,randTerrain)*100;
      altura4=noise(e*0.01,(i+tam)*0.01,randTerrain)*100;
      
      
      translate(i,0,e);
      //box(tam,altura1,tam);
      beginShape();
      
      vertex(0,altura1,0);
      vertex(tam,altura2,0);
      vertex(tam,altura3,tam);
      vertex(0,altura4,tam);
      
      endShape();
      
      popMatrix();
    } 
  }

  popMatrix();
}

void mouseClicked(){
  randTerrain=random(1000);
}
