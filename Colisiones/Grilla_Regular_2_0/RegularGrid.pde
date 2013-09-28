class RegularGrid implements ColisionDetection {
  private ArrayList<Element> grilla[][];
  private int totalWidth = floor(width/maxSize);
  private int totalHeight = floor(height/maxSize);

  public RegularGrid() {
    grilla = new ArrayList[totalWidth][totalHeight];
    for (int i=0;i<totalWidth;i++) {
      for (int j=0;j<totalHeight;j++) {
        grilla[i][j]= new ArrayList<Element>();
      }
    }
  }

  void calculate(ArrayList<Element> elements) {
    //CORROBORO LAS CELDAS CONTRA LAS QUE PUEDO COLISIONAR
    for (Element currentElement:elements) addElement(currentElement);

    int colisiones = 0;
    //RECORRER TODA LA MATRIZ
    for (int x=0;x<totalWidth;x++) {
      for (int y=0;y<totalHeight;y++) {
        while (grilla[x][y].size () > 0) {
          Element currentElement = grilla[x][y].get(0);
          grilla[x][y].remove(0);
          for (Element tmpElem:grilla[x][y]) {
            if (currentElement.collided(tmpElem)) {
              tmpElem.myColor = color(255, 0, 0);
              currentElement.myColor = color(255, 0, 0);
            }
          }
        }
      }
    }
    //println("Colisiones totales con grilla: "+ colisiones + " - Colisiones totales sin grilla: " + elements.size()*elements.size());
  }

  void addElement(Element currentElement) {
    int tmpX, tmpY, startX, startY, endX, endY;
    int tmpRadius; 

    startX=floor((currentElement.pos.x-currentElement.radius)/maxSize);
    endX=floor((currentElement.pos.x+currentElement.radius)/maxSize);
    if (startX<0) startX=0;
    if (endX>=totalWidth) endX=totalWidth-1;

    startY=floor((currentElement.pos.y-currentElement.radius)/maxSize);
    endY=floor((currentElement.pos.y+currentElement.radius)/maxSize);
    if (startY<0) startY=0;
    if (endY>=totalHeight) endY=totalHeight-1;

    for (int currentX=startX; currentX<=endX; currentX++) {            
      for (int currentY=startY; currentY<=endY; currentY++) {
        grilla[currentX][currentY].add(currentElement);
        if (renderGrid) {
          fill(50, 100, 50);
          rect(currentX*maxSize, currentY*maxSize, maxSize, maxSize);
        }
      }
    }
  }

  
}

