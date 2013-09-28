//Hojas
class Item extends ComponentItem{
  public Item(String name, String imgPath, int size){
    this.name = name;
    img = loadImage(imgPath);
    img.resize(size, size);
  }
  
  private Item(String name, PImage img){
    this.name = name;
    this.img = img;
  }
  
  ComponentItem clone(){
    return new Item(name, img);
  }
  
  int getCantItems(){
    return 1; 
  }
  
  void setParent(CompositeItem parent){
    this.parent = parent;
  }
  
  CompositeItem getParent(){
    return parent;
  }
  
  boolean isComposite(){
    return false;
  }
}
