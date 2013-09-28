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
    for (Element element:elements) grilla[floor(element.pos.x/maxSize)][floor(element.pos.y/maxSize)].add(element);

    int colisiones = 0;
    //RECORRER TODA LA MATRIZ
    for (int x=0;x<totalWidth;x++) {
      for (int y=0;y<totalHeight;y++) {
        
        int tmpX, tmpY, startX, startY, endX, endY;
        int tmpRadius; 
        while (grilla[x][y].size() > 0) {
          Element currentElement = grilla[x][y].get(0);
          grilla[x][y].remove(0);
          tmpX = floor(currentElement.pos.x/maxSize);
          tmpY = floor(currentElement.pos.y/maxSize);
          tmpRadius = ceil(currentElement.radius/maxSize);
          
          startX=tmpX-tmpRadius;
          endX=tmpX+tmpRadius;
          if (startX<0) startX=0;
          if (endX>=totalWidth) endX=totalWidth-1;
          
          startY=tmpY-tmpRadius;
          endY=tmpY+tmpRadius;
          if (startY<0) startY=0;
          if (endY>=totalHeight) endY=totalHeight-1;
          
          println(startX + " " + endX + " --- " + startY + " " + endY);
          //CORROBORO LAS CELDAS CONTRA LAS QUE PUEDO COLISIONAR
          for (int currentX=startX; currentX<=endX; currentX++) {            
            for (int currentY=startY; currentY<=endY; currentY++) {
              //println("("+currentX+ ", " + currentY+")");
              //colisiones++;
              fill(20,100,200);
              rect(currentX*maxSize, currentY*maxSize, maxSize, maxSize);
              ArrayList<Element> currentCell = grilla[currentX][currentY];
              for (Element tmpElem:currentCell) {
                //CORROBORO LAS COLISIONES EFECTIVAS
                
                if (currentElement.collided(tmpElem)) {
                  tmpElem.myColor = color(255, 0, 0);
                  currentElement.myColor = color(255, 0, 0);
                }
              }
            }
          }
        }
      }
    }
    println("Colisiones totales con grilla: "+ colisiones + " - Colisiones totales sin grilla: " + elements.size()*elements.size());
  }
}

