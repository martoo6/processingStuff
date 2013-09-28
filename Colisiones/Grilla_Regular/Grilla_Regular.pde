import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

float maxSize = 50 ; //El tamaño maximo de cada celda es el tamaño maximo de cada elemento

ArrayList<Element> elements = new ArrayList<Element>();

boolean renderNoiseField =false;
boolean renderGrid = false;
boolean pause=false;

float detail=0.01;

long lastTime;
int cantPariculas=5;

ColisionDetection colisionDetector;


void setup() {
  size(800, 600);
  background(0);
  colisionDetector = new RegularGrid();
  for (int i=0;i<cantPariculas;i++) elements.add(new Element());
}

void draw() {
  frame.setTitle(Integer.toString((int)(frameRate)));
  background(0);

  //NOISE FIELD
  if (renderNoiseField) {
    for (int x=0;x<width;x+=10) {
      for (int y=0;y<height;y+=10) {
        stroke(0, 255, 255);
        line(x, y, x+cos(noise(x*detail, y*detail)*TWO_PI)*5, y+sin(noise(x*detail, y*detail)*TWO_PI)*5);
      }
    }
  }

  //GRILLA
  if(renderGrid){
    stroke(100,0,100);
    for (int x=0;x<width;x+=maxSize) {
      line(x,0,x,height);
    }
    for (int y=0;y<height;y+=maxSize) {
      line(0,y,width,y);
    }
  }
  
  //MOVER CON CLICK
  if (mousePressed) for (Element element:elements) element.move(random(-15, 15), random(-15, 15));
  
  
  //MOVER ELEMENTOS
  long elapsedTime = millis()-lastTime;
  lastTime = millis();
  for (Element element:elements) {
    element.myColor = color(255);//VUELVE A BLANCO
    if(pause) element.move(elapsedTime*0.1);
  }
  //COLISIONES
  colisionDetector.calculate(elements);
     
    //RENDER ELEMENTOS
    noStroke();
    for (Element element:elements) element.render();
  }
  
void keyPressed() {
  if (keyCode == UP) {
    detail+=0.0001;
  }
  if (keyCode == DOWN) {
    if(! (detail<=0.000001)) detail-=0.0001;
  }
  if (keyCode == 'G') {
    renderGrid=!renderGrid;
  }
  if (keyCode == 'N') {
    renderNoiseField=!renderNoiseField;
  }
  if (keyCode == '1') {
    colisionDetector = new RegularColision();
  }
  if (keyCode == '2') {
    colisionDetector = new RegularGrid();
  }
  if (keyCode == 'P') {
    pause =!pause;
  }
}
