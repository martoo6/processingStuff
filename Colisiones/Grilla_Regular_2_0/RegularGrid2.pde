class RegularGrid2 implements ColisionDetection {
  private ArrayList<Element> grilla[][];
  private int totalWidth = floor(width/maxSize);
  private int totalHeight = floor(height/maxSize);

  public RegularGrid2() {
    grilla = new ArrayList[totalWidth][totalHeight];
    for (int i=0;i<totalWidth;i++) {
      for (int j=0;j<totalHeight;j++) {
        grilla[i][j]= new ArrayList<Element>();
      }
    }
  }

  void calculate(ArrayList<Element> elements) {
    int tmpX, tmpY, startX, startY, endX, endY;
    int tmpRadius; 
    float diagonal = dist(0,0,maxSize, maxSize)/2;
    //CORROBORO LAS CELDAS CONTRA LAS QUE PUEDO COLISIONAR
    for (Element currentElement:elements) {
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
      

      
      for (int currentX=startX; currentX<=endX; currentX++) {            
        for (int currentY=startY; currentY<=endY; currentY++) {
          //En este caso se toma a cada celda como un circulo calculando la colision entre la misma y el circulo
          if(dist(currentElement.pos.x, currentElement.pos.y, currentX*maxSize+maxSize/2, currentY*maxSize+maxSize/2)<currentElement.radius+diagonal){
            grilla[currentX][currentY].add(currentElement);
            if(renderGrid){
              fill(50,100,50);
              ellipse(currentX*maxSize+maxSize/2, currentY*maxSize+maxSize/2, diagonal*2, diagonal*2);
            }    
          }
        }
      }
    }

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
}
