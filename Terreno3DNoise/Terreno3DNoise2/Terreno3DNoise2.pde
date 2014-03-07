 import peasy.*;

PShape formas;
PShape forma;
float randTerrain=random(1000);
int tam=5;
int grillaTam=250;
PShape shapes[][];

PeasyCam cam;

void setup(){
  size(900,600, P3D);
  //stroke(100);
  noStroke();
  fill(255);
  background(0);
 
float grilla[][]= new float [grillaTam+1][grillaTam+1];
shapes= new PShape [grillaTam+1][grillaTam+1];

 float altura1, altura2, altura3, altura4;
  for(int i=0;i<grillaTam+1;i++){
    for(int e=0;e<grillaTam+1;e++){
     grilla[i][e]=noise(e*0.1,i*0.1,randTerrain)*100;
    } 
  }

  cam = new PeasyCam(this, 400);
  cam.setMinimumDistance(5);
  cam.setMaximumDistance(800);
  
  formas = createShape(GROUP);
  
  for(int i=0;i<grillaTam;i++){
    for(int e=0;e<grillaTam;e++){
      shapes[i][e]=createShape(TRIANGLE_FAN);
      
      shapes[i][e].fill(map(grilla[i][e],0,150,255,0));
      shapes[i][e].translate(i*tam,0,e*tam);
      shapes[i][e].vertex(0,grilla[i][e],0);
      shapes[i][e].vertex(0,grilla[i][e+1],tam);
      shapes[i][e].vertex(tam,grilla[i+1][e+1],tam);
      shapes[i][e].vertex(tam,grilla[i+1][e],0);
      shapes[i][e].end(CLOSE);
      
      formas.addChild(shapes[i][e]);
    } 
  }
}

void draw(){
  background(0);
  frame.setTitle(Integer.toString((int)(frameRate)));
  
  pushMatrix();
    rotateY(frameCount*0.01);
    translate((-grillaTam*tam/2),0,(-grillaTam*tam/2));    
    shape(formas);
  popMatrix();
}

void mouseClicked(){
  randTerrain=random(1000);
}
