ArrayList formas;
static int MAXFORMAS =10;

void setup(){
  size(800,600);
  smooth();
  frameRate(30);
  background(0);
  formas = new ArrayList();
  for(int i=0;i<MAXFORMAS;i++){
    int xPos=(int)random(width);
    int yPos=(int)random(height);
    formas.add(new Circulo(xPos,yPos,90, 10));
  }
}

void draw(){
  background(0);
  for(int i=0;i<formas.size();i++){
    Forma forma=(Forma)formas.get(i);
    forma.display();
    forma.updatePos2D();
  }
}

public abstract class Forma{
  int xPos, yPos, zPos, tamForma;
  int maxMov=2;
  void display(){
    this.display();
  }
  void updatePos2D(){
    xPos+=(int)random(-maxMov,maxMov);
    yPos+=(int)random(-maxMov,maxMov);
    xPos=constrain(xPos,0,width);
    yPos=constrain(yPos,0,height);
  }
  void updatePos3D(){
    xPos+=(int)random(-maxMov,maxMov);
    yPos+=(int)random(-maxMov,maxMov);
    zPos+=(int)random(-maxMov,maxMov);
    xPos=constrain(xPos,0,width);
    yPos=constrain(yPos,0,height);
  }
}

