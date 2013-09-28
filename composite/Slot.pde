class Slot{
  PVector pos;
  ComponentItem componentItem;
  
  public Slot(PVector pos){
    this.pos = pos;
  }
  
  void render(){
    stroke(0);
    strokeWeight(3);
    pushMatrix();
    translate(pos.x, pos.y);
    fill(196, 118, 8);
    rect(0,0,itemSize,itemSize);
    if(componentItem!=null) componentItem.render();
    popMatrix();
  }
  
  void setItem(ComponentItem componentItem){
    this.componentItem = componentItem;
  }
  
}
