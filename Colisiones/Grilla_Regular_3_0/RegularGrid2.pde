class RegularGrid2 implements ColisionDetection {
  private HashMap<Long, Element> grilla[][];
  private int totalWidth = floor(width/maxSize);
  private int totalHeight = floor(height/maxSize);
  private color newColor = color(255, 0, 0);

  void init(ArrayList<Element> elements) {
    totalWidth = floor(width/maxSize);
    totalHeight = floor(height/maxSize);
    grilla = new HashMap[totalWidth][totalHeight];
    for (int i=0;i<totalWidth;i++) for (int j=0;j<totalHeight;j++) grilla[i][j]= new HashMap<Long, Element>();
    for (Element element:elements) hasMoved(element);
  }

  void calculate() {
    Element[] cellElements;
    float diagonal = dist(0,0,maxSize, maxSize)/2;
    for (int x=0;x<totalWidth;x++)  for (int y=0;y<totalHeight;y++) {
      cellElements = grilla[x][y].values().toArray(new Element[0]);
      for (int i=0; i<grilla[x][y].values().size()-1; i++)  for (int j=i+1; j<grilla[x][y].values().size(); j++) {
        if (cellElements[i].collided(cellElements[j])) {
          cellElements[i].myColor = newColor;
          cellElements[j].myColor = newColor;
        }
      }
    }
  }

  void hasMoved(Element currentElement) {
    int startX, startY, endX, endY, dStartX, dStartY, dEndX, dEndY;
    float radius=currentElement.radius;

    //ELIMINADO
    dStartX=floor((currentElement.lastPos.x-radius)/maxSize);
    dEndX=floor((currentElement.lastPos.x+radius)/maxSize);
    if (dStartX<0) dStartX=0;
    else if (dEndX>=totalWidth) dEndX=totalWidth-1;

    dStartY=floor((currentElement.lastPos.y-radius)/maxSize);
    dEndY=floor((currentElement.lastPos.y+radius)/maxSize);
    if (dStartY<0) dStartY=0;
    else if (dEndY>=totalHeight) dEndY=totalHeight-1;

    //AGREGADO
    startX=floor((currentElement.pos.x-radius)/maxSize);
    endX=floor((currentElement.pos.x+radius)/maxSize);
    if (startX<0) startX=0;
    else if (endX>=totalWidth) endX=totalWidth-1;

    startY=floor((currentElement.pos.y-radius)/maxSize);
    endY=floor((currentElement.pos.y+radius)/maxSize);
    if (startY<0) startY=0;
    else if (endY>=totalHeight) endY=totalHeight-1;
    
    for (int x=dStartX; x<=dEndX; x++) for (int y=dStartY; y<=dEndY; y++)  grilla[x][y].remove(currentElement.id);
    for (int x=startX; x<=endX; x++) for (int y=startY; y<=endY; y++) grilla[x][y].put(currentElement.id, currentElement);
  }

  void destroyed(Element currentElement) {
    int tmpX, tmpY, startX, startY, endX, endY;
    float radius=currentElement.radius;

    startX=floor((currentElement.pos.x-radius)/maxSize);
    endX=floor((currentElement.pos.x+radius)/maxSize);
    if (startX<0) startX=0;
    else if (endX>=totalWidth) endX=totalWidth-1;

    startY=floor((currentElement.pos.y-radius)/maxSize);
    endY=floor((currentElement.pos.y+radius)/maxSize);
    if (startY<0) startY=0; 
    else if (endY>=totalHeight) endY=totalHeight-1;

    for (int currentX=startX; currentX<=endX; currentX++) for (int currentY=startY; currentY<=endY; currentY++)  grilla[currentX][currentY].remove(currentElement.id);
  }

  public void renderGrid() {
    fill(50, 100, 50);    
    for (int x=0;x<totalWidth;x++)  for (int y=0;y<totalHeight;y++)  if (grilla[x][y].values().size()>0) ellipse(x*maxSize+maxSize/2, y*maxSize+maxSize/2, maxSize, maxSize);
  }
}

