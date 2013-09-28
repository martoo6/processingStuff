import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

float maxSize = 10 ; //El tamaño maximo de cada celda es el tamaño maximo de cada elemento
//float maxSize = 200 ; //El tamaño maximo de cada celda es el tamaño maximo de cada elemento

ArrayList<Element> elements = new ArrayList<Element>();

ColisionDetection[] colisionDetectors = { new RegularColision(), new RegularGrid(), new RegularGrid2()};

boolean renderNoiseField =false;
boolean renderGrid = false;
boolean pause=true;

float detail=0.01;

long lastTime;
int cantPariculas=300;

ColisionDetection colisionDetector;
MovementObserver movementObserver;


void setup() {
  size(1200, 700);
  background(0);
  colisionDetector = colisionDetectors[0];
  
  
  movementObserver = new MovementObserver(){
    public void hasMoved(Element element) {colisionDetector.hasMoved(element);}
    public void destroyed(Element element) { colisionDetector.destroyed(element);}
  };
  
  for (int i=0;i<cantPariculas;i++) elements.add(new Element().addObserver(movementObserver));
  
  colisionDetector.init(elements);
}

void draw() {
  frame.setTitle(Integer.toString((int)(frameRate))+" - Cantidad de Elementos: "+Integer.toString((int)(elements.size())));
  background(0);

  //NOISE FIELD
  if (renderNoiseField) {
    stroke(0, 255, 255);
    for (int x=0;x<width;x+=10) for (int y=0;y<height;y+=10) line(x, y, x+cos(noise(x*detail, y*detail)*TWO_PI)*5, y+sin(noise(x*detail, y*detail)*TWO_PI)*5);
  }

  //MOVER CON CLICK
  if (mousePressed) for (Element element:elements) element.move(random(-15, 15), random(-15, 15));

  //MOVER ELEMENTOS
  long elapsedTime = millis()-lastTime;
  lastTime = millis();
  
  for(Element element:elements) element.myColor = color(255);//VUELVE A BLANCO
  int cant=floor(elements.size()*0.1); 
  if (pause) for (int i=0;i<cant;i++) elements.get(i).move(elapsedTime*0.1);
  //COLISIONES
  colisionDetector.calculate();

  //GRILLA
  if (renderGrid) {
    stroke(100, 0, 100);
    for (int x=0;x<width;x+=maxSize) line(x, 0, x, height);
    for (int y=0;y<height;y+=maxSize) line(0, y, width, y);
    colisionDetector.renderGrid();
  }
  //RENDER ELEMENTOS
  noStroke();
  for (Element element:elements) element.render();
}

void keyPressed() {
  if (keyCode == UP) {
    detail+=0.001;
  }
  if (keyCode == DOWN) {
    if (! (detail<=0.000001)) detail-=0.001;
  }
  if (keyCode == RIGHT) {
    for (int i=0;i<100;i++) {
      Element tmpElement = new Element();
      tmpElement.addObserver(movementObserver);
      tmpElement.move(0);
      elements.add(tmpElement);
    }
  }
  if (keyCode == LEFT) {
    Element currentElement;
    int cant = 100;
    if(elements.size()<100) cant=elements.size(); 
    for (int i=0;i<cant;i++) {
      currentElement = elements.get(0);
      currentElement.destroy();
      elements.remove(0);
    }
  }
  if (keyCode == 'G') {
    renderGrid=!renderGrid;
  }
  if (keyCode == 'N') {
    renderNoiseField=!renderNoiseField;
  }
  if (keyCode == '1') {
    colisionDetector = colisionDetectors[0];
    colisionDetector.init(elements);
  }
  if (keyCode == '2') {
    colisionDetector = colisionDetectors[1];
    colisionDetector.init(elements);
  }
  if (keyCode == '3') {
    colisionDetector = colisionDetectors[2];
    colisionDetector.init(elements);
  }
  if (keyCode == '4') {
    colisionDetector = colisionDetectors[3];
    colisionDetector.init(elements);
  }
  if (keyCode == 'P') {
    pause =!pause;
  }
}

