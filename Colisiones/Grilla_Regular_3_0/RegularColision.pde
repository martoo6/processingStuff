import java.util.*;

class RegularColision implements ColisionDetection {
  ArrayList<Element> elements;
  void calculate() {
    for (int i=0; i<elements.size(); i++) {
      for (int j=i+1; j<elements.size(); j++) {
        if (elements.get(i).collided(elements.get(j))) {
          elements.get(i).myColor = color(255, 0, 0);
          elements.get(j).myColor = color(255, 0, 0);
        }
      }
    }
  }
  
  void hasMoved(Element element){}
  
  void destroyed(Element element){}
  
  void init(ArrayList<Element> elements){
    this.elements = elements;
  }
  
  public void renderGrid(){}
}

