abstract class ComponentItem{
  String name;
  PImage img;
  PVector pos=new PVector(0,0);
  CompositeItem parent;
  
  String getName(){
    return name;
  }
  
  void setPos(PVector pos){
    this.pos = pos;
  }
  
  void render(){
    pushMatrix();
    translate(pos.x, pos.y);
    image(img, 0, 0);
    fill(0);
    text(getCantItems(), 5, img.height-10);
    popMatrix();
  }
  
  abstract boolean isComposite();
  abstract int getCantItems();
  abstract ComponentItem clone();
}
