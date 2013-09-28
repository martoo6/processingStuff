//Nodos no terminales
class CompositeItem extends ComponentItem{
  ArrayList<ComponentItem> childs = new ArrayList<ComponentItem>();
  
  public CompositeItem(String name, String imgPath, int size){
    this.name = name;
    img = loadImage(imgPath);
    img.resize(size, size);
  }
  
  private CompositeItem(String name, PImage img){
    this.name = name;
    this.img = img;
  }
  
  CompositeItem clone(){
    return new CompositeItem(name, img);
  }
  
  void addChild(ComponentItem componentItem){
    childs.add(componentItem);
    componentItem.parent = this;
  }
  
  void removeChild(Item item){
    childs.remove(item);
  }
  
  ComponentItem getChild(int i){
    return childs.get(i);
  }
  
  int getCantItems(){
    int sum=0;
    for(ComponentItem child:childs) sum+=child.getCantItems();
    return sum; 
  }
  
  boolean isComposite(){ return true;}
}
