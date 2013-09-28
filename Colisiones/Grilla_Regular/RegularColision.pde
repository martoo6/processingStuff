class RegularColision implements ColisionDetection {  
  void calculate(ArrayList<Element> elements) {
    for (int i=0; i<elements.size()-1; i++) {
      for (int j=i+1; j<elements.size(); j++) { 
        if (elements.get(i).collided(elements.get(j))) {
          elements.get(i).myColor = color(255, 0, 0);
          elements.get(j).myColor = color(255, 0, 0);
        }
      }
    }
  }
}

